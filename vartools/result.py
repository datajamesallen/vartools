import pandas
import os
from pandasql import sqldf
import matplotlib.pyplot as plot
import numpy as np
import sqlite3
import math
import sys
import re
import datetime
from scipy.optimize import curve_fit
from matplotlib.backends.backend_pdf import PdfPages
import matplotlib.lines as mlines
from scipy import stats
from statistics import stdev
from configparser import RawConfigParser
from pydrc import fit4pdrc
from itertools import cycle

BASEDIR = os.path.dirname(__file__)

def dbcon():
    """ returns the sqlite database connection object from the database
    that is currently 'linked' in the config.ini file """
    configdir = os.path.join(BASEDIR, 'config.ini')
    data = open(configdir, 'r+')
    parser = RawConfigParser()
    parser.read(configdir)
    dbpath = parser.get('database','path')
    con = sqlite3.connect(dbpath)
    return con

def to_M(logres, base = -6):
    """
    converts to molar with the given base
    """
    return (10**logres) * (10**(-base))

def multi_getdbdata(Varlist, assay):
    con = dbcon()
    cursor = con.cursor()
    fullrows = []
    for Variant in Varlist:
        query = "SELECT * FROM varoocytes WHERE Variant = '" + Variant + "' AND assay = '" + assay + "' UNION SELECT * FROM wtoocytes WHERE Variant = '" + Variant + "' AND assay = '" + assay + "'"
        cursor.execute(query)
        for row in cursor:
            fullrows.append(row)
    names = [description[0] for description in cursor.description]
    df = pandas.DataFrame(fullrows, columns = names)
    df = df.drop(['upload_time'], axis=1)
    df = df.drop_duplicates(subset=['file'],keep='first')
    return(df)

def match_file_order(row):
    ret = re.search(r"[\d]*.[\d]*$",row.file)
    if ret:
        return float(ret.group())
    else:
        return 0

def getdbdata(Variant, assay):
    con = dbcon()
    cursor = con.cursor()
    query = "SELECT * FROM varoocytes WHERE Variant = '" + Variant + "' AND assay = '" + assay + "' UNION SELECT * FROM wtoocytes WHERE Variant = '" + Variant + "' AND assay = '" + assay + "'"
    cursor.execute(query)
    names = [description[0] for description in cursor.description]
    rows = cursor.fetchall()
    df = pandas.DataFrame(rows, columns = names)
    df['file_order'] = df.apply(match_file_order, axis=1)
    df = df.sort_values(by = ['glun1','glun2','date_rec','file_order'])
    df = df.drop(['file_order'], axis=1)
    df = df.drop(['Variant'], axis=1)
    df = df.drop(['upload_time'], axis=1)
    return(df)

def getdbdata_date(date, assay):
    con = dbcon()
    cursor = con.cursor()
    query = "SELECT * FROM varoocytes WHERE date_rec = '" + date + "' AND assay = '" + assay + "' UNION SELECT * FROM wtoocytes WHERE date_rec = '" + date + "' AND assay = '" + assay +"'"
    cursor.execute(query)
    names = [description[0] for description in cursor.description]
    rows = cursor.fetchall()
    df = pandas.DataFrame(rows, columns = names)
    df['file_order'] = df.apply(match_file_order, axis=1)
    df = df.sort_values(by = ['glun1','glun2','date_rec','file_order'])
    df = df.drop(['file_order'], axis=1)
    df = df.drop(['Variant'], axis=1)
    df = df.drop(['upload_time'], axis=1)
    return(df)

def download_date_assay_csv(date, assay):
    """ download a csv file of all the data associated with a variant / date """
    df = getdbdata_date(date,assay)
    name = date + "-" + assay + ".csv"
    df.to_csv(name, sep=',',index=False)
    return None

def download_variant_assay_csv(Variant, assay):
    """ download a csv file of all data associated with a variants / assay """
    df = getdbdata(Variant, assay)
    name = Variant + "_" + assay + ".csv"
    df.to_csv(name, sep=',',index=False)
    return None

def re_fit_data(file_name, top_c = True, bot_c = True):
    """
    re-fits a downloaded variant assay pair 

    optionally supply top_c (True/False)
    or bot_c (True/False)
    to constrian the top or bot of the hillsiope equation
    """

    from pydrc import fit4pdrc as fit

    with open(file_name, 'r') as f:
        res = []
        for line in f:
            res.append(line.rstrip().split(','))
    header = res[0]
    res = res[1:] # no header
    dose = [-10,-9.53,-9,-8.53,-8,-7.53,-7,-6.53,-6,-5.53,-5,-4.53,-4,-3.53,-3,-2.53,-2,-1.53,-1]
    new_res = [header]
    for row in res:
        fit_dose = []
        fit_res = []
        response = row[5:24]
        # need to get non missing data !
        for i,item in enumerate(response):
            if item == '':
                continue
            else:
                fit_res.append(float(item))
                fit_dose.append(dose[i])
        print(fit_dose)
        print(fit_res)
        ret = fit(fit_dose, fit_res, top_const=top_c, bot_const=bot_c)
        fits = [ret['c'],ret['h'],ret['b'],ret['t'],ret['p'],ret['i']]
        # create a new row with the newly created fits
        new_row = row[:26] + fits + row[32:]
        print(new_row)
        new_res.append(new_row)
    with open(file_name, 'w') as f:
        for line in new_res:
            f.write(','.join([str(x) for x in line]) + '\n')
    return None

def re_upload_data(file_name):
    """ replaces a given variant assay result with the updated information """

    now = datetime.datetime.now()
    # first convert data into the proper data type so that SQLite knows how to deal with it
    newdatalist = []
    for row in datalist:
        #print(row)
        intro = row[:4]
        dat = row[4:25]
        info = row[25:27]
        fit = row[27:33]
        assay = row[33]
        try:
            date_rec = datetime.datetime.strptime(row[33],'%Y-%m-%d').date()
        except:
            try:
                date_rec = datetime.datetime.strptime(row[33], '%d/%m/%y').date()
            except:
                date_rec = None
        try:
            date_inj = datetime.datetime.strptime(row[34],'%Y-%m-%d').date()
        except:
            try:
                date_inj = datetime.datetime.strptime(row[34], '%d/%m/%y').date()
            except:
                date_inj = None
        volt = row[35]
        last = row[36:]
        newdat = []
        for item in dat:
            if item == None:
                newdat.append(item)
            else:
                try:
                    item = float(item)
                    newdat.append(item)
                except:
                    newdat.append(None)
        newfit = []
        for item in fit:
            if item == None:
                newfit.append(item)
            else:
                newfit.append(float(item))
        newrow = intro + newdat + info + newfit + [assay] + [date_rec] + [date_inj] + [volt] + last
        newdatalist.append(newrow)


def getaa(variant):
    result = re.findall(r'\d+', variant)
    try:
        ret = int(result[1])
    except:
        ret = 0
    return(ret)

def mindist(myList, myNumber):
    return min(myList, key=lambda x:abs(x-myNumber))

def mean(numbers):
    return float(sum(numbers)) / max(len(numbers), 1)

def meanplot(df, parameter = "logec50"):
    """
    GOAL: plot means of EC50/IC50/single dose data in a scatter/boxplot style
    """
    if parameter == "logec50":
        dose = [-10,-9.53,-9,-8.53,-8,-7.53,-7,-6.53,-6,-5.53,-5,-4.53,-4,-3.53,-3,-2.53,-2,-1.53,-1]
        uM = [touM(x) for x in dose]
        minx = min(df["logec50"])
        mind = min(dose, key = lambda x:abs(x-minx))
        j = 0
        for i, item in enumerate(dose):
            if item == mind:
                j = i - 1
        maxx = max(df["logec50"])
        maxd = min(dose, key = lambda x:abs(x-maxx))
        k = 0
        for i, item in enumerate(dose):
            if item == maxd:
                k = i + 1
        yticks = dose[j:k+1]
    if df.empty:
        return(None)
    acode = df["assay"][0]
    print(acode)
    if acode == "gluDRC":
        ylab = "log[Glutmate] EC50"
        #yticks = (-5.00,-5.53,-6.00,-6.53)
    elif acode == "glyDRC":
        ylab = "log[Glycine] EC50"
        #yticks = (-5.53,-6.00,-6.53,-7.00)
    elif acode == "mgDRC":
        yticks = False
        ylab = "log[Magnesium] IC50"
    elif acode == "znDRC" and parameter == "logec50":
        ylab = "log[Zinc] IC50"
        #yticks = (-7.53,-8.00,-8.52)
    elif acode == "znDRC" and parameter == "ymin":
        ylab = "log[Zinc] ymin"
        yticks = False
    elif parameter == "pH_per_inhib":
        ylab = "pH % inhibition 6.8 / 7.6"
        yticks = False
    df['date_rec'] = pandas.to_datetime(df['date_rec'])
    df['date_rec'] = df['date_rec'].dt.strftime('%m.%d.%Y')
    df['aanum'] = df['glun2'].apply(getaa)
    df = df[df[parameter].notnull()]
    df = df.sort_values(by = ['aanum','Variant'])
    #print(df)
    grouped = df.groupby(['glun1', 'glun2'], sort = False)
    column = parameter

    wtvals = []
    names, vals, xs = [], [], []
    for i, (name, subdf) in enumerate(grouped):
        if name[1] == 'h2A-WT':
            wtvals.append(subdf[column].tolist())
        names.append(name[1])
        vals.append(subdf[column].tolist())
        xs.append(np.random.normal(i+1, 0.04, subdf.shape[0]))

    fig, ax = plot.subplots()
    fig.set_size_inches(10,10)
    plot.subplots_adjust(bottom = 0.2)
    plot.ylabel(ylab)
    try:
        ax.boxplot(vals, labels = names)
    except:
        return(None)
    for x, val in zip(xs, vals):
        ax.scatter(x, val, alpha = 0.4)
    xbar = np.mean(wtvals[0])
    print(wtvals[0])
    print(xbar)
    sd = np.std(wtvals[0])
    print(sd)
    n = len(wtvals[0])
    degf = n-1
    print(n)
    t = stats.t.ppf(0.95, degf)
    print(t)
    conf = t*(sd/np.sqrt(n))
    minconf = xbar - conf
    maxconf = xbar + conf
    ax.axhline(xbar,color='black',linestyle ='--')
    ax.axhspan(minconf, maxconf, color='grey')
    if not yticks:
        pass
    else:
        plot.yticks(yticks)
    ax.set_xticklabels(names, rotation=90, fontsize = 10)
    ax.grid(True)
    return(fig)


def download_pub_variant_assay(Variant, assay):
    df = getdbdata(Variant, assay)
    fig = makepub(df)
    plot.savefig(Variant + '_' + assay + '.png')
    plot.close(fig)
    return None

def download_result_variant_assay(Variant, assay):
    df = getdbdata(Variant, assay)
    fig = makeresult(df)
    plot.savefig(Variant + '_' + assay + '_result.png')
    plot.close(fig)
    return None

def download_result_date_assay(date, assay):
    df = getdbdata_date(date, assay)
    fig = makeresult(df)
    plot.savefig(date + '_' + assay + '_result.png')
    plot.close(fig)
    return None
    

def makepub(df, logx = False):
    """
    GOAL: make a publication-ready figure of the data fed to this function

    note: I don't find this method best for analyzing data because it overepresents the quality of the data
    but has the cleanest overal presentation and easiest to iterpret visualization of the dose-response/inhibition
    relationship so it is the good for publication/presentation
    """
    if df.empty:
        return(None)
    # group the data by glun1 / glun2 subunits
    groups = sqldf("select distinct glun1, glun2 from df order by glun1, glun2")
    # find the mean of each of the parameters in the fit function
    # these may not be used as they end up producing a rather ugly graph
    # default to showing the fits
    # create different titles / descriptions based on the assay from the df
    acode = df['assay'][0]
    top_const_var = False # initializing the constraint variables for fitting
    bot_const_var = False
    if acode == "gluDRC":
        if not logx:
            aname = "[Glutamate] M"
        else:
            aname = "log[Glutamate] M"
        title = "Glutamate Dose Response"
    elif acode == "glyDRC":
        if not logx:
            aname = "[Glycine] M"
        else:
            aname = "log[Glycine] M"
        title = "Glycine Dose Response"
    elif acode == "mgDRC":
        top_const_var = True
        if not logx:
            aname = "[Magnesium] M"
        else:
            aname = "log[Magnesium] M"
        title = "Magnesium Dose Inhibition"
    elif acode == "znDRC":
        top_const_var = True
        if not logx:
            aname = "[Zinc] M"
        else:
            aname = "log[Zinc] M"
        title = "Zinc Dose Inhibition"
    elif acode == "pHDRC":
        top_const_var = True
        if not logx:
            aname = "pH"
        else:
            aname = "-pH"
        title = "Proton Dose Inhibition"
    else:
        sys.exit("Unexpected assay code: " + acode)
    # set up the plots
    fig, ax = plot.subplots()
    plot.ylabel("% Max Current")
    plot.xlabel(aname)
    ax.set_xticks = (np.arange(-10,0,step = 1))
    if not logx:
        ax.semilogx()
    ax.set_yticks(np.arange(0,125,step = 25))
    ax.set_ylim([0,100])
    ax.grid(True, linestyle='--', color = '#D3D3D3')
    fig.suptitle(title)
    doseh = ['logm10','logm9p5','logm9','logm8p5','logm8','logm7p5','logm7','logm6p5','logm6','logm5p5','logm5','logm4p5','logm4','logm3p5','logm3','logm2p5','logm2','logm1p5','logm1']
    doses = [-10,-9.5228,-9,-8.5228,-8,-7.5228,-7,-6.5228,-6,-5.5228,-5,-4.5228,-4,-3.5228,-3,-2.5228,-2,-1.5228,-1]
    doses_M = [to_M(dose, base = 0) for dose in doses]
    # a list of colors to iterate through
    color=list(plot.cm.Set1(np.linspace(0,1,len(groups))))
    marker_list = ('o','v','s','+','D','.',',','^','<','>','1','2','3','4','p','*','h','H','x','d','|','_')
    marker = cycle(marker_list)
    all_legend_handles = []
    for i in range(0,len(groups)):
        clr = color[i]
        # find the glun1 and glun2 of this iteration, and then grab the appropriate data from that iteration
        iglun1 = groups['glun1'][i]
        iglun2 = groups['glun2'][i]
        oo = sqldf("select * from df where glun1 = '" + iglun1 + "' and glun2 = '" + iglun2 + "'")
        # now that we have the whole line, lets create arrays of the relavent data
        # this will create the means,sd,sem,n,etc at each dose for the data
        # this will be use to fit the data again such that the line goes through these datapoints and looks
        # nice and ready for publication
        sdlist = []
        meanlist = []
        countlist = []
        xlist = []
        xlist_M = []
        for m in range(0,19):
            if math.isnan(oo[doseh[m]].mean()):
                continue
            sdlist.append(oo[doseh[m]].std())
            meanlist.append(oo[doseh[m]].mean())
            countlist.append(oo[doseh[m]].count())
            xlist.append(doses[m])
            xlist_M.append(doses_M[m])
        semlist = []
        for v in range(0,len(sdlist)):
            semlist.append(sdlist[v]/math.sqrt(countlist[v]))
        ret = fit4pdrc(xlist, meanlist, top_const = top_const_var, bot_const = bot_const_var)
        b = ret['b']
        t = ret['t']
        h = ret['h']
        c = ret['c']
        if ret['p'] == -1:
            fit = False
        else:
            fit = True
        minx = min(xlist) # use for adjusting size of window
        maxx = max(xlist)
        x = np.linspace(minx-1.53,maxx+1.53,num = 100)
        #ax.annotate("EC50: %s" %rc, xy=(rc, mid))
        imarker = next(marker)
        if fit:
            y = eval('(b+((t-b)/(1+10**((c-x)*h))))')
            if not logx:
                newx = [to_M(i, base = 0) for i in x]
                x = newx
            ax.plot(x,y, color = clr, zorder=0)
        if logx:
            ax.scatter(xlist, meanlist, marker = imarker, color = clr, edgecolors = 'black', zorder=20)
            plot.errorbar(xlist, meanlist, color = clr, yerr = sdlist, linestyle="None", capsize=6, zorder=10)
        else:
            ax.scatter(xlist_M, meanlist, marker = imarker, color = clr, edgecolors = 'black', zorder=20)
            plot.errorbar(xlist_M, meanlist, color = clr, yerr = sdlist, linestyle="None", capsize=6, zorder=10)
        # the below will add each of the created 'legend handles' which are just
        # the things we want to show in the legend, like color shape
        # this is done so that we get the line and scatter to have a single legend
        legend_handle_row = mlines.Line2D([],[], color = clr, label = iglun1 + '/' + iglun2, marker = imarker)
        all_legend_handles.append(legend_handle_row)
    ax.legend(handles = all_legend_handles)

    return(fig)

def drcfunc1(x, c, h):
    return((0+((100-0)/(1+10**((c-x)*h)))))
def drcfunc2(x, b, c, h):
    return((b+((100-b)/(1+10**((c-x)*h)))))
def drcfunc3(x, t, c, h):
    return((b+((t-0)/(1+10**((c-x)*h)))))
def drcfunc4(x, t, b, c, h):
    return((b+((t-b)/(1+10**((c-x)*h)))))

def makeresult(df, logx = False):
    """
    Intended to make a figure for data review and internal data anaylsis purposes
    Individual fits of individual curves
    """
    if df.empty:
        return(None)
    #df = df.sort_values(by=['Variant','date_rec','file'])
    grouped = df.groupby(['glun1','glun2'])
    groups = []
    for key,item in enumerate(grouped):
        groups.append(item[0][0]+"/"+item[0][1])
    grouplen = len(groups)
    acode = df['assay'][0]
    if acode == "gluDRC":
        if not logx:
            aname = "[Glutamate] M"
        else:
            aname = "log[Glutamate] M"
        title = "Glutamate Dose Response"
    elif acode == "glyDRC":
        if not logx:
            aname = "[Glycine] M"
        else:
            aname = "log[Glycine] M"
        title = "Glycine Dose Response"
    elif acode == "mgDRC":
        if not logx:
            aname = "[Magnesium] M"
        else:
            aname = "log[Magnesium] M"
        title = "Magnesium Dose Inhibition"
    elif acode == "znDRC":
        if not logx:
            aname = "[Zinc] M"
        else:
            aname = "log[Zinc] M"
        title = "Zinc Dose Inhibition"
    elif acode == "pHDRC":
        top_const_var = True
        if not logx:
            aname = "pH"
        else:
            aname = "-pH"
        title = "Proton Dose Inhibition"
    else:
        sys.exit("Unexpected assay code: " + acode)
    fig, ax = plot.subplots()
    plot.ylabel("% Max Current")
    plot.xlabel(aname)
    ax.set_xticks(np.arange(-10,0,step = 1))
    if not logx:
        ax.semilogx()
    ax.set_yticks(np.arange(0,125,step = 25))
    ax.set_ylim([0,100])
    ax.grid(True, linestyle='--', color = '#D3D3D3')
    plot.suptitle(title, fontsize=12)
    doseh = ['logm10','logm9p5','logm9','logm8p5','logm8','logm7p5','logm7','logm6p5','logm6','logm5p5','logm5','logm4p5','logm4','logm3p5','logm3','logm2p5','logm2','logm1p5','logm1']
    doses = [-10,-9.5228,-9,-8.5228,-8,-7.5228,-7,-6.5228,-6,-5.5228,-5,-4.5228,-4,-3.5228,-3,-2.5228,-2,-1.5228,-1]
    doses_M = [to_M(dose, base = 0) for dose in doses]
    color=list(plot.cm.Set1(np.linspace(0,1,grouplen)))
    marker_list = ('o','v','s','+','D','.',',','^','<','>','1','2','3','4','p','*','h','H','x','d','|','_')
    marker = cycle(marker_list)
    all_legend_1_handles = []
    all_legend_2_handles = []
    # create the legends for the plot
    for index, item in enumerate(groups):
        clr = color[index]
        legend_1_handle_row = mlines.Line2D([],[], color = clr, label = item)
        all_legend_1_handles.append(legend_1_handle_row)

    # now create a line and scatter for each oocyte
    for i,row in df.iterrows():
        fname = row["file"]
        iglun1 = row["glun1"]
        iglun2 = row["glun2"]
        imarker = next(marker)
        xlist, ylist, xlist_M = [], [], []
        for m in range(0,19):
            if not row[doseh[m]]:
                continue
            ylist.append(row[doseh[m]])
            xlist.append(doses[m])
            xlist_M.append(doses_M[m]) # for the molar doses
        for cindex,item in enumerate(groups):
            if item == (iglun1 + "/" + iglun2):
                clr = color[cindex]
                break
        c = row["logec50"]
        if not c:
            if logx:
                ax.scatter(xlist,ylist,color=clr)
            else:
                ax.scatter(xlist_M,ylist,color=clr)
            continue
        rc = round(c, 2)
        h = row["hillslope"]
        b = row["ymin"]
        t = row["ymax"]
        mid = (100-(t-b)/2) + (i*4)
        xmin = min(xlist)
        xmax = max(xlist)
        x = np.linspace(xmin-1.53,xmax+1.53,num = 100)
        y = eval('(b+((t-b)/(1+10**((c-x)*h))))')
        if not logx:
            newx = [to_M(i, base = 0) for i in x]
            x = newx
        #ax.annotate("EC50: %s" %rc, xy=(rc, mid))
        try:
            ax.plot(x,y, color = clr, alpha = 0.5, zorder=0)
        except:
            continue
        try:
            if logx:
                ax.scatter(xlist, ylist, color = clr, marker = imarker, edgecolors = 'black', alpha = 0.5, zorder=20)
            else:
                ax.scatter(xlist_M, ylist, color = clr, marker = imarker, edgecolors = 'black', alpha = 0.5, zorder=20)
        except:
            continue

        legend_2_handle_row = mlines.Line2D([],[], color = clr, label = fname, marker = imarker, markeredgecolor = 'black', alpha = 0.5)
        all_legend_2_handles.append(legend_2_handle_row)
    box = ax.get_position()
    ax.set_position([box.x0, box.y0, box.width * 0.80, box.height])
    leg1 = ax.legend(handles = all_legend_1_handles, bbox_to_anchor = (0.75,0.885), bbox_transform = fig.transFigure, loc = "upper left", prop={'size':5.5})
    leg2 = ax.legend(handles = all_legend_2_handles, bbox_to_anchor = (0.75,0.815), bbox_transform = fig.transFigure, loc = "upper left", prop={'size':5.5})
    ax.add_artist(leg1)
    return(fig)

def getvariants():
    con = dbcon()
    cursor = con.cursor()
    query = "SELECT DISTINCT Variant from varoocytes"
    cursor.execute(query)
    varlist = []
    for result in cursor:
        varlist.append(result[0])
    return(varlist)

def calcfoldshift(EC50_A, EC50_B):
    if EC50_A/EC50_B > 1:
        fs = EC50_A/EC50_B
    else:
        fs = EC50_B/EC50_A
    return fs

def welch_ttest(mean_A, sd_A, n_A, mean_B, sd_B, n_B):
    s_delta = ((sd_A**2/n_A)+(sd_B**2/n_B))
    t = (mean_A - mean_B) / np.sqrt(s_delta)
    df = s_delta**2 / ((sd_A**2/n_A)**2/(n_A-1) + (sd_B**2/n_B)**2/(n_B-1))
    p = stats.t.cdf(t, df=df)
    return p

def table_results(assay = 'gluDRC', parameter = 'logec50'):
    """ aggregates the data into a table of results """
    varlist = getvariants()
    gludf = getmultivar(varlist, assay)
    gluwt = gludf[(gludf.glun1 == "h1a-WT") & (gludf.glun2 == "h2B-WT")]
    gluvar = gludf[(gludf.glun2 != "h2B-WT")]
    gluvaragg = gluvar[[parameter,'Variant']].groupby(['Variant']).agg(['mean','std','count'])
    gluwtagg = gluwt[[parameter,'Variant']].groupby(['Variant']).agg(['mean','std','count'])
    gluvaragg.columns = [parameter + "_mean", parameter + "_std", parameter + "_n"]
    gluwtagg.columns = [parameter + "_mean", parameter + "_std", parameter + "_n"]
    #print(gluvaragg[parameter]['mean'])
    #gluwtmean = gluwtagg[parameter]['mean']
    print(gluvaragg)
    joined = gluvaragg.join(gluwtagg, on = "Variant", lsuffix = "_var", rsuffix = "_wt")
    #print(joined['logec50_mean_var'])
    joined['uM_var'] = joined[parameter + '_mean_var'].apply(touM)
    joined['uM_wt'] = joined[parameter + '_mean_wt'].apply(touM)
    print(joined['uM_var'])
    joined['fs'] = joined.apply(lambda x: calcfoldshift(x['uM_var'], x['uM_wt']), axis = 1)
    joined['p'] = joined.apply(lambda x: welch_ttest(x[parameter + '_mean_var'], x[parameter + '_std_var'], x[parameter + '_n_var'], x[parameter + '_mean_wt'], x[parameter + '_std_wt'], x[parameter + '_n_wt']), axis = 1)
    joined['bonferroni_sig'] = np.where(joined['p'] < 0.05/len(joined), '*', 'ns')
    joined.to_csv(assay + "_result.csv")
    print(len(joined))
    return None

def prem4sat(fromlist = True):
    if fromlist:
        with open('pm4list.csv','r') as f:
            pm4list = f.readlines()
            pm4list = pm4list[2:]
        print(pm4list)
        varlist = []
        for row in pm4list:
            row = row.split(",")
            varlist.append(row[4].strip())
    else:
        varlist = getvariants()
    pp = PdfPages("preM4_Summary.pdf")
    gludf = getmultivar(varlist, 'gluDRC')
    glufig = meanplot(gludf, parameter = 'logec50')
    pp.savefig(glufig)
    glydf = getmultivar(varlist, 'glyDRC')
    glyfig = meanplot(glydf, parameter = 'logec50')
    pp.savefig(glyfig)
    pHdf = getmultivar(varlist, 'pH')
    pHfig = meanplot(pHdf, parameter = 'pH_per_inhib')
    pp.savefig(pHfig)
    zndf = getmultivar(varlist, 'znDRC')
    znicfig = meanplot(zndf, parameter = 'logec50')
    pp.savefig(znicfig)
    znyfig = meanplot(zndf, parameter = 'ymin')
    pp.savefig(znyfig)
    pp.close()

def make_all_curve():
    assaylist = ['gluDRC','glyDRC','mgDRC','znDRC']
    varlist = getvariants()
    pp = PdfPages("all_curve.pdf")
    for variant in varlist:
        for assay in assaylist:
            df = getdbdata(variant, assay)
            fig0 = makeresult(df)
            if fig0:
                pp.savefig(fig0)
            plot.close(fig0)
    pp.close()

def makeallpub():
    assaylist = ['gluDRC','glyDRC','pH','mgDRC','znDRC']
    varlist = getvariants()
    print(varlist)
    for variant in varlist:
        print("Creating figures for: " + variant)
        pp = PdfPages("dir/figures/" + variant + ".pdf")
        for assay in assaylist:
            df = getdbdata(variant, assay)
            if assay in ["gluDRC","glyDRC","mgDRC"]:
                fig0 = makeresult(df)
                if fig0:
                    pp.savefig(fig0)
                plot.close(fig0)
                fig1 = makepub(df)
                if fig1:
                    pp.savefig(fig1)
                plot.close(fig1)
                fig2 = meanplot(df, parameter = "logec50")
                if fig2:
                    pp.savefig(fig2)
                plot.close(fig2)
            elif assay == "pH":
                fig2 = meanplot(df, parameter = "pH_per_inhib")
                if fig2:
                    pp.savefig(fig2)
                plot.close(fig2)
            elif assay == "znDRC":
                fig0 = makeresult(df)
                if fig0:
                    pp.savefig(fig0)
                plot.close(fig0)
                fig1 = makepub(df)
                if fig1:
                    pp.savefig(fig1)
                plot.close(fig1)
                fig2 = meanplot(df, parameter = "logec50")
                if fig2:
                    pp.savefig(fig2)
                plot.close(fig2)
                fig3 = meanplot(df, parameter = "ymin")
                if fig3:
                    pp.savefig(fig3)
                plot.close(fig3)
        pp.close()
            #plot.savefig("dir/figures/" + variant + "-" + assay + ".png", dpi = 300)
            #plot.close(fig)

def get_assays(Variant):
    con = dbcon()
    cursor = con.cursor()
    query = "select distinct(assay) from varoocytes where Variant = '" + Variant + "'"
    cursor.execute(query)
    assaylist = []
    for row in cursor:
        assaylist.append(str(row[0]))
    return assaylist

def get_assays_date(date):
    con = dbcon()
    cursor = con.cursor()
    query = "select distinct(assay) from varoocytes where date_rec = '" + date + "'"
    cursor.execute(query)
    assaylist = []
    for row in cursor:
        assaylist.append(str(row[0]))
    return assaylist

def get_dates():
    con = dbcon()
    cursor = con.cursor()
    query = "select distinct(date_rec) from varoocytes"
    cursor.execute(query)
    datelist = []
    for row in cursor:
        iteration = row[0]
        if iteration == None:
            date_string = "Unknown"
        else:
            date_string = iteration[:10]
        datelist.append(date_string)
    return datelist

def create_directory(check_all):
    print(check_all)
    """
    This command will generate an updated version of the data contained in the database
    in an organized file system format filled with csv files, png images, pdf's etc
    """
    cwd = os.getcwd()
    print("Current directory: " + cwd)
    print("Create a database filysystem from the linked database in this directory?")
    print("WARNING: if you have files here with the same name, they will be overwritten")
    response = input("Proceed? (y/n)")
    if response != "y":
        sys.exit()
    varlist = getvariants()
    vardir = os.path.join(cwd, 'by_variant')
    if not os.path.exists(vardir):
        os.makedirs(vardir)
    for variant in varlist:
        print(variant)
        # create a folder for each variant
        var_path = os.path.join(vardir, variant)
        if (os.path.exists(var_path) and not check_all):
            continue
        if not os.path.exists(var_path):
            os.makedirs(var_path)
        assaylist = get_assays(variant)
        for assay in assaylist:
            # create a folder for each assay
            var_assay_path = os.path.join(var_path, assay)
            if not os.path.exists(var_assay_path):
                os.makedirs(var_assay_path)
            os.chdir(var_assay_path)
            if assay not in ("pH"):
                try:
                    download_result_variant_assay(variant, assay)
                except:
                    pass
                #if variant in ('h1a-D789N','h1a-F654C','h1a-N650I','h2A-A733T','h2A-D776Y','h2A-L411Q','h2A-R518C','h2A-R695Q','h2A-V713G','h2B-A1267S','h2B-A713V','h2B-F525V','h2B-G689C','h2B-I695T','h2B-M818L','h2B-R1099fsX51','h2B-R519G','h2B-T514A'):
                # these variants are causing an error right now,
                # please fix the error then remove this
                #    continue
                try:
                    download_pub_variant_assay(variant, assay)
                except:
                    pass
            download_variant_assay_csv(variant, assay)
    datedir = os.path.join(cwd, 'by_date')
    datelist = get_dates()
    if not os.path.exists(datedir):
        os.makedirs(datedir)
    for date in datelist:
        date_path = os.path.join(datedir, date.replace("-","_"))
        print(date_path)
        if not os.path.exists(date_path):
            os.makedirs(date_path)
        assaylist = get_assays_date(date)
        for assay in assaylist:
            date_assay_path = os.path.join(date_path, assay)
            if not os.path.exists(date_assay_path):
                os.makedirs(date_assay_path)
            os.chdir(date_assay_path)
            if assay not in ("pH"):
                download_result_date_assay(date,assay)
            download_date_assay(date, assay)
    print("Directory created")
    return None
        

