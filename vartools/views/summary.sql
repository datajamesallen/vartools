DROP VIEW IF EXISTS `summary`;

CREATE 
 VIEW `summary` AS 
SELECT
all_variants.Variant,
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
FROM
all_variants
LEFT JOIN
oosumglu
on
oosumglu.Variant = all_variants.Variant
left join
oosumgly
on
oosumgly.Variant = all_variants.Variant
left join
oosumph
on
oosumph.Variant = all_variants.Variant
left join
oosummg
on
oosummg.Variant = all_variants.Variant
left join
oosumzn
on
oosumzn.Variant = all_variants.Variant
LEFT JOIN
`gnomADv2.1.1`
on
`gnomADv2.1.1`.Variant = all_variants.Variant
left join
clinvarsumvar
on
clinvarsumvar.Variant = all_variants.Variant
