--
-- Structure for view `varoosumvar`
--
-- Used to aggregate oocyte variants data by variant
--
DROP VIEW IF EXISTS `varoosumvar`;

CREATE 
 VIEW `varoosumvar` AS 
select
   `varoocytes`.`Variant` AS `Variant`,
   `varoocytes`.`assay` AS `assay`,
   `varoocytes`.`glun1` AS `var_glun1`,
   `varoocytes`.`glun2` AS `var_glun2`,
   count(`varoocytes`.`file`) AS `var_n_oocytes`,
   count((`varoocytes`.`conv` = 1)) AS `var_n_fit`,
   count(distinct `varoocytes`.`date_rec`) AS `var_date_rec_count`,
   round(avg(`varoocytes`.`logec50`),2) AS `var_avg_logec50`,
   round(stdev(`varoocytes`.`logec50`),2) AS `var_std_logec50`,
   round(avg(`varoocytes`.`hillslope`),2) AS `var_avg_hillslope`,
   round(stdev(`varoocytes`.`hillslope`),2) AS `var_std_hillslope`,
   round(avg(`varoocytes`.`ymin`),2) AS `var_avg_ymin`,
   round(stdev(`varoocytes`.`ymin`),2) AS `var_std_ymin`,
   round(avg(`varoocytes`.`ymax`),2) AS `var_avg_ymax`,
   round(stdev(`varoocytes`.`ymax`),2) AS `var_std_ymax`,
   round(avg(`varoocytes`.`pH_per_inhib`),2) AS `var_avg_pH_per_inhib`,
   round(stdev(`varoocytes`.`pH_per_inhib`),2) AS `var_std_pH_per_inhib`,
   round(avg((
      case
         when
            (
               `varoocytes`.`assay` = 'mgDRC'
            )
         then
            `varoocytes`.`logm4p5`
         else
            NULL 
      end
   )),2) AS `var_avg_logm4p5_mg`, 
   round(stdev((
      case
         when
            (
               `varoocytes`.`assay` = 'mgDRC'
            )
         then
            `varoocytes`.`logm4p5`
         else
            NULL 
      end
   )),2) AS `var_std_logm4p5_mg`, 
   round(avg((
      case
         when
            (
               `varoocytes`.`assay` = 'znDRC'
            )
         then
            `varoocytes`.`logm8`
         else
            NULL 
      end
   )),2) AS `var_avg_logm8_zn`, 
   round(stdev((
      case
         when
            (
               `varoocytes`.`assay` = 'znDRC'
            )
         then
            `varoocytes`.`logm8`
         else
            NULL 
      end
   )),2) AS `var_std_logm8_zn`,
   round(avg((
      case
         when
            (
               `varoocytes`.`assay` = 'znDRC'
            )
         then
            `varoocytes`.`logm6p5`
         else
            NULL 
      end
   )),2) AS `var_avg_logm6p5_zn`, 
   round(stdev((
      case
         when
            (
               `varoocytes`.`assay` = 'znDRC'
            )
         then
            `varoocytes`.`logm6p5`
         else
            NULL 
      end
   )),2) AS `var_std_logm6p5_zn`,


   round(avg((
      case
         when
            (
               `varoocytes`.`assay` = 'gluDRC'
            )
         then
            `varoocytes`.`logm5p5`
         else
            NULL 
      end
   )),2) AS `var_avg_logm5p5_glu`, 
   round(stdev((
      case
         when
            (
               `varoocytes`.`assay` = 'gluDRC'
            )
         then
            `varoocytes`.`logm5p5`
         else
            NULL 
      end
   )),2) AS `var_std_logm5p5_glu`,
   round(avg((
      case
         when
            (
               `varoocytes`.`assay` = 'glyDRC'
            )
         then
            `varoocytes`.`logm6`
         else
            NULL 
      end
   )),2) AS `var_avg_logm6_gly`, 
   round(stdev((
      case
         when
            (
               `varoocytes`.`assay` = 'glyDRC'
            )
         then
            `varoocytes`.`logm6`
         else
            NULL 
      end
   )),2) AS `var_std_logm6_gly`,


    
round(avg(`varoocytes`.`i`),2) AS `var_avg_i`, 
round(stdev(`varoocytes`.`i`),2) AS `var_std_i` 
from
   `varoocytes` 
group by
   `varoocytes`.`Variant`, `varoocytes`.`assay` ;

