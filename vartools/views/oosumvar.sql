--
-- Structure for view `wtoosumvar`
--
-- Used to aggregate oocyte variants data by variant
--
DROP VIEW IF EXISTS `oosumvar`;

CREATE 
 VIEW `oosumvar` AS 
select
varoosumvar.Variant as Variant,
varoosumvar.assay as assay,
varoosumvar.var_glun1,
varoosumvar.var_glun2,
wtoosumvar.wt_glun1,
wtoosumvar.wt_glun2,
wtoosumvar.wt_n_oocytes,
wtoosumvar.wt_n_fit,
varoosumvar.var_n_oocytes,
varoosumvar.var_n_fit,
varoosumvar.var_date_rec_count,
wtoosumvar.wt_date_rec_count,
varoosumvar.var_avg_logec50,
varoosumvar.var_std_logec50,
wtoosumvar.wt_avg_logec50,
wtoosumvar.wt_std_logec50,
varoosumvar.var_avg_hillslope,
varoosumvar.var_std_hillslope,
wtoosumvar.wt_avg_hillslope,
wtoosumvar.wt_std_hillslope,
varoosumvar.var_avg_ymin,
varoosumvar.var_std_ymin,
wtoosumvar.wt_avg_ymin,
wtoosumvar.wt_std_ymin,
varoosumvar.var_avg_ymax,
varoosumvar.var_std_ymax,
wtoosumvar.wt_avg_ymax,
wtoosumvar.wt_std_ymax,
varoosumvar.var_avg_pH_per_inhib,
varoosumvar.var_std_pH_per_inhib,
wtoosumvar.wt_avg_pH_per_inhib,
wtoosumvar.wt_std_pH_per_inhib,
varoosumvar.var_avg_logm4p5_mg,
varoosumvar.var_std_logm4p5_mg,
wtoosumvar.wt_avg_logm4p5_mg,
wtoosumvar.wt_std_logm4p5_mg,
varoosumvar.var_avg_logm8_zn,
varoosumvar.var_std_logm8_zn,
wtoosumvar.wt_avg_logm8_zn,
wtoosumvar.wt_std_logm8_zn,
varoosumvar.var_avg_logm6p5_zn,
varoosumvar.var_std_logm6p5_zn,
wtoosumvar.wt_avg_logm6p5_zn,
wtoosumvar.wt_std_logm6p5_zn,
varoosumvar.var_avg_logm5p5_glu,
varoosumvar.var_std_logm5p5_glu,
wtoosumvar.wt_avg_logm5p5_glu,
wtoosumvar.wt_std_logm5p5_glu,
varoosumvar.var_avg_logm6_gly,
varoosumvar.var_std_logm6_gly,
wtoosumvar.wt_avg_logm6_gly,
wtoosumvar.wt_std_logm6_gly,
varoosumvar.var_avg_i,
varoosumvar.var_std_i,
wtoosumvar.wt_avg_i,
wtoosumvar.wt_std_i
from varoosumvar
left join
wtoosumvar
on varoosumvar.Variant = wtoosumvar.Variant and varoosumvar.assay = wtoosumvar.assay




