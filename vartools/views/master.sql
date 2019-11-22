DROP VIEW IF EXISTS `summary`;

CREATE 
 VIEW `summary` AS 
select 
human_variants_sumvar.Gene,
human_variants_sumvar.aaNum,
human_variants_sumvar.cDNA,
human_variants_sumvar.Protein,
human_variants_sumvar.Variant,
human_variants_sumvar.RefSeq,
gnomadsumvar.gnomad_all_AlleleCount,
gnomadsumvar.gnomad_all_AlleleNum,
gnomadsumvar.gnomad_controls_AlleleCount,
gnomadsumvar.gnomad_controls_AlleleNum,
gnomadsumvar.gnomad_nonneuro_AlleleCount,
gnomadsumvar.gnomad_nonneuro_AlleleNum,
gnomadsumvar.gnomad_nontopmed_AlleleCount,
gnomadsumvar.gnomad_nontopmed_AlleleNum,
clinvarsumvar.clinvar_CountObs,
clinvarsumvar.clinvar_DateCreated,
clinvarsumvar.clinvar_AlleleSource,
clinvarsumvar.clinvar_TestingMethod,
clinvarsumvar.clinvar_OrgName,
clinvarsumvar.clinvar_AffectedStatus,
clinvarsumvar.clinvar_Phenotype,
lemkesumvar.lemke_Count,
lemkesumvar.lemke_Zygosity,
lemkesumvar.lemke_AlleleSource,
lemkesumvar.lemke_Sex,
lemkesumvar.lemke_Seq,
lemkesumvar.lemke_Pubmed,
lemkesumvar.lemke_DevDelay,
lemkesumvar.lemke_Seizures,
topmedsumvar.topmed_AlleleCount AS count_TOPMed,
topmedsumvar.topmed_AlleleNum AS denom_TOPMed,
/*--Glutamate*/
/*--wt*/
oosumglu.wt_n_oocytes as wt_n_rec_glu,
oosumglu.wt_n_fit as wt_n_fit_glu,
oosumglu.wt_date_rec_count as wt_n_date_glu,
oosumglu.wt_avg_logec50 as wt_avg_logEC50_glu,
oosumglu.wt_std_logec50 as wt_std_logEC50_glu,
oosumglu.wt_avg_hillslope as wt_avg_hillslope_glu,
oosumglu.wt_std_hillslope as wt_std_hillslope_glu,
oosumglu.wt_avg_ymin as wt_avg_ymin_glu,
oosumglu.wt_std_ymin as wt_std_ymin_glu,
oosumglu.wt_avg_ymax as wt_avg_ymax_glu,
oosumglu.wt_std_ymax as wt_std_ymax_glu,
oosumglu.wt_avg_logm5p5_glu,
oosumglu.wt_std_logm5p5_glu,
oosumglu.wt_avg_i as wt_avg_i_glu,
oosumglu.wt_std_i as wt_std_i_glu,

/*--var*/
oosumglu.var_n_oocytes as var_n_rec_glu,
oosumglu.var_n_fit as var_n_fit_glu,
oosumglu.var_date_rec_count as var_n_date_glu,
oosumglu.var_avg_logec50 as var_avg_logEC50_glu,
oosumglu.var_std_logec50 as var_std_logEC50_glu,
oosumglu.var_avg_hillslope as var_avg_hillslope_glu,
oosumglu.var_std_hillslope as var_std_hillslope_glu,
oosumglu.var_avg_ymin as var_avg_ymin_glu,
oosumglu.var_std_ymin as var_std_ymin_glu,
oosumglu.var_avg_ymax as var_avg_ymax_glu,
oosumglu.var_std_ymax as var_std_ymax_glu,
oosumglu.var_avg_logm5p5_glu,
oosumglu.var_std_logm5p5_glu,
oosumglu.var_avg_i as var_avg_i_glu,
oosumglu.var_std_i as var_std_i_glu,
/*--Glycine*/
/*--wt*/
oosumgly.wt_n_oocytes as wt_n_rec_gly,
oosumgly.wt_n_fit as wt_n_fit_gly,
oosumgly.wt_date_rec_count as wt_n_frogs_gly,
oosumgly.wt_avg_logec50 as wt_avg_logEC50_gly,
oosumgly.wt_std_logec50 as wt_std_logEC50_gly,
oosumgly.wt_avg_hillslope as wt_avg_hillslope_gly,
oosumgly.wt_std_hillslope as wt_std_hillslope_gly,
oosumgly.wt_avg_ymin as wt_avg_ymin_gly,
oosumgly.wt_std_ymin as wt_std_ymin_gly,
oosumgly.wt_avg_ymax as wt_avg_ymax_gly,
oosumgly.wt_std_ymax as wt_std_ymax_gly,
oosumgly.wt_avg_logm6_gly,
oosumgly.wt_std_logm6_gly,
oosumgly.wt_avg_i as wt_avg_i_gly,
oosumgly.wt_std_i as wt_std_i_gly,
/*--var*/
oosumgly.var_n_oocytes as var_n_rec_gly,
oosumgly.var_n_fit as var_n_fit_gly,
oosumgly.var_date_rec_count as var_n_date_gly,
oosumgly.var_avg_logec50 as var_avg_logEC50_gly,
oosumgly.var_std_logec50 as var_std_logEC50_gly,
oosumgly.var_avg_hillslope as var_avg_hillslope_gly,
oosumgly.var_std_hillslope as var_std_hillslope_gly,
oosumgly.var_avg_ymin as var_avg_ymin_gly,
oosumgly.var_std_ymin as var_std_ymin_gly,
oosumgly.var_avg_ymax as var_avg_ymax_gly,
oosumgly.var_std_ymax as var_std_ymax_gly,
oosumgly.var_avg_logm6_gly,
oosumgly.var_std_logm6_gly,
oosumgly.var_avg_i as var_avg_i_gly,
oosumgly.var_std_i as var_std_i_gly,
/*--pH*/
/*--wt*/
oosumph.wt_n_oocytes as wt_n_rec_ph,
oosumph.wt_date_rec_count as wt_n_date_ph,
oosumph.wt_avg_pH_per_inhib as wt_avg_logm6p8_ph,
oosumph.wt_std_pH_per_inhib as wt_std_logm6p8_ph,
oosumph.wt_avg_i as wt_avg_i_ph,
oosumph.wt_std_i as wt_std_i_ph,
/*--var*/
oosumph.var_n_oocytes as var_n_rec_ph,
oosumph.var_date_rec_count as var_n_date_ph,
oosumph.var_avg_pH_per_inhib as var_avg_logm6p8_ph,
oosumph.var_std_pH_per_inhib as var_std_logm6p8_ph,
oosumph.var_avg_i as var_avg_i_ph,
oosumph.var_std_i as var_std_i_ph,
/*--Magnesium*/
/*--wt*/
oosummg.wt_n_oocytes as wt_n_rec_mg,
oosummg.wt_n_fit as wt_n_fit_mg,
oosummg.wt_date_rec_count as wt_n_date_mg,
oosummg.wt_avg_logec50 as wt_avg_logIC50_mg,
oosummg.wt_std_logec50 as wt_std_logIC50_mg,
oosummg.wt_avg_hillslope as wt_avg_hillslope_mg,
oosummg.wt_std_hillslope as wt_std_hillslope_mg,
oosummg.wt_avg_ymin as wt_avg_ymin_mg,
oosummg.wt_std_ymin as wt_std_ymin_mg,
oosummg.wt_avg_ymax as wt_avg_ymax_mg,
oosummg.wt_std_ymax as wt_std_ymax_mg,
oosummg.wt_avg_logm4p5_mg,
oosummg.wt_std_logm4p5_mg,
oosummg.wt_avg_i as wt_avg_i_mg,
oosummg.wt_std_i as wt_std_i_mg,
/*--var*/
oosummg.var_n_oocytes as var_n_rec_mg,
oosummg.var_n_fit as var_n_fit_mg,
oosummg.var_date_rec_count as var_n_date_mg,
oosummg.var_avg_logec50 as var_avg_logIC50_mg,
oosummg.var_std_logec50 as var_std_logIC50_mg,
oosummg.var_avg_hillslope as var_avg_hillslope_mg,
oosummg.var_std_hillslope as var_std_hillslope_mg,
oosummg.var_avg_ymin as var_avg_ymin_mg,
oosummg.var_std_ymin as var_std_ymin_mg,
oosummg.var_avg_ymax as var_avg_ymax_mg,
oosummg.var_std_ymax as var_std_ymax_mg,
oosummg.var_avg_logm4p5_mg,
oosummg.var_std_logm4p5_mg,
oosummg.var_avg_i as var_avg_i_mg,
oosummg.var_std_i as var_std_i_mg,
/*--Zinc*/
/*--wt*/
oosumzn.wt_n_oocytes as wt_n_rec_zn,
oosumzn.wt_n_fit as wt_n_fit_zn,
oosumzn.wt_date_rec_count as wt_n_date_zn,
oosumzn.wt_avg_logec50 as wt_avg_logIC50_zn,
oosumzn.wt_std_logec50 as wt_std_logIC50_zn,
oosumzn.wt_avg_hillslope as wt_avg_hillslope_zn,
oosumzn.wt_std_hillslope as wt_std_hillslope_zn,
oosumzn.wt_avg_ymin as wt_avg_ymin_zn,
oosumzn.wt_std_ymin as wt_std_ymin_zn,
oosumzn.wt_avg_ymax as wt_avg_ymax_zn,
oosumzn.wt_std_ymax as wt_std_ymax_zn,
oosumzn.wt_avg_logm8_zn,
oosumzn.wt_std_logm8_zn,
oosumzn.wt_avg_logm6p5_zn,
oosumzn.wt_std_logm6p5_zn,
oosumzn.wt_avg_i as wt_avg_i_zn,
oosumzn.wt_std_i as wt_std_i_zn,
/*--var*/
oosumzn.var_n_oocytes as var_n_rec_zn,
oosumzn.var_n_fit as var_n_fit_zn,
oosumzn.var_date_rec_count as var_n_date_zn,
oosumzn.var_avg_logec50 as var_avg_logIC50_zn,
oosumzn.var_std_logec50 as var_std_logIC50_zn,
oosumzn.var_avg_hillslope as var_avg_hillslope_zn,
oosumzn.var_std_hillslope as var_std_hillslope_zn,
oosumzn.var_avg_ymin as var_avg_ymin_zn,
oosumzn.var_std_ymin as var_std_ymin_zn,
oosumzn.var_avg_ymax as var_avg_ymax_zn,
oosumzn.var_std_ymax as var_std_ymax_zn,
oosumzn.var_avg_logm8_zn,
oosumzn.var_std_logm8_zn,
oosumzn.var_avg_logm6p5_zn,
oosumzn.var_std_logm6p5_zn,
oosumzn.var_avg_i as var_avg_i_zn,
oosumzn.var_std_i as var_std_i_zn
from
human_variants_sumvar
left join
oosumglu
on
oosumglu.Variant = human_variants_sumvar.Variant
left join
oosumgly
on
oosumgly.Variant = human_variants_sumvar.Variant
left join
oosumph
on
oosumph.Variant = human_variants_sumvar.Variant
left join
oosummg
on
oosummg.Variant = human_variants_sumvar.Variant
left join
oosumzn
on
oosumzn.Variant = human_variants_sumvar.Variant
left join
gnomadsumvar
on
gnomadsumvar.Variant = human_variants_sumvar.Variant
left join
clinvarsumvar
on
clinvarsumvar.Variant = human_variants_sumvar.Variant
left join
lemkesumvar
on
lemkesumvar.Variant = human_variants_sumvar.Variant
left join
topmedsumvar
on
topmedsumvar.Variant = human_variants_sumvar.Variant
