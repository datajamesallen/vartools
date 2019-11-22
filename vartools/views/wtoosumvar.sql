--
-- Structure for view `wtoosumvar`
--
-- Used to aggregate oocyte variants data by variant
--
DROP VIEW IF EXISTS `wtoosumvar`;

CREATE 
 VIEW `wtoosumvar` AS 
select
   `wtoocytes`.`Variant` AS `Variant`,
   `wtoocytes`.`assay` AS `assay`,
   `wtoocytes`.`glun1` AS `wt_glun1`,
   `wtoocytes`.`glun2` AS `wt_glun2`,
   count(`wtoocytes`.`file`) AS `wt_n_oocytes`,
   count((`wtoocytes`.`conv` = 1)) AS `wt_n_fit`,
   count(distinct `wtoocytes`.`date_rec`) AS `wt_date_rec_count`,
   round(avg(`wtoocytes`.`logec50`),2) AS `wt_avg_logec50`,
   round(stdev(`wtoocytes`.`logec50`),2) AS `wt_std_logec50`,
   round(avg(`wtoocytes`.`hillslope`),2) AS `wt_avg_hillslope`,
   round(stdev(`wtoocytes`.`hillslope`),2) AS `wt_std_hillslope`,
   round(avg(`wtoocytes`.`ymin`),2) AS `wt_avg_ymin`,
   round(stdev(`wtoocytes`.`ymin`),2) AS `wt_std_ymin`,
   round(avg(`wtoocytes`.`ymax`),2) AS `wt_avg_ymax`,
   round(stdev(`wtoocytes`.`ymax`),2) AS `wt_std_ymax`,
   round(avg(`wtoocytes`.`pH_per_inhib`),2) AS `wt_avg_pH_per_inhib`,
   round(stdev(`wtoocytes`.`pH_per_inhib`),2) AS `wt_std_pH_per_inhib`,
   round(avg((
      case
         when
            (
               `wtoocytes`.`assay` = 'mgDRC'
            )
         then
            `wtoocytes`.`logm4p5`
         else
            NULL 
      end
   )),2) AS `wt_avg_logm4p5_mg`, 
   round(stdev((
      case
         when
            (
               `wtoocytes`.`assay` = 'mgDRC'
            )
         then
            `wtoocytes`.`logm4p5`
         else
            NULL 
      end
   )),2) AS `wt_std_logm4p5_mg`, 
   round(avg((
      case
         when
            (
               `wtoocytes`.`assay` = 'znDRC'
            )
         then
            `wtoocytes`.`logm8`
         else
            NULL 
      end
   )),2) AS `wt_avg_logm8_zn`, 
   round(stdev((
      case
         when
            (
               `wtoocytes`.`assay` = 'znDRC'
            )
         then
            `wtoocytes`.`logm8`
         else
            NULL 
      end
   )),2) AS `wt_std_logm8_zn`,
   round(avg((
      case
         when
            (
               `wtoocytes`.`assay` = 'znDRC'
            )
         then
            `wtoocytes`.`logm6p5`
         else
            NULL 
      end
   )),2) AS `wt_avg_logm6p5_zn`, 
   round(stdev((
      case
         when
            (
               `wtoocytes`.`assay` = 'znDRC'
            )
         then
            `wtoocytes`.`logm6p5`
         else
            NULL 
      end
   )),2) AS `wt_std_logm6p5_zn`,

   round(avg((
      case
         when
            (
               `wtoocytes`.`assay` = 'gluDRC'
            )
         then
            `wtoocytes`.`logm5p5`
         else
            NULL 
      end
   )),2) AS `wt_avg_logm5p5_glu`, 
   round(stdev((
      case
         when
            (
               `wtoocytes`.`assay` = 'gluDRC'
            )
         then
            `wtoocytes`.`logm5p5`
         else
            NULL 
      end
   )),2) AS `wt_std_logm5p5_glu`,
   round(avg((
      case
         when
            (
               `wtoocytes`.`assay` = 'glyDRC'
            )
         then
            `wtoocytes`.`logm6`
         else
            NULL 
      end
   )),2) AS `wt_avg_logm6_gly`, 
   round(stdev((
      case
         when
            (
               `wtoocytes`.`assay` = 'glyDRC'
            )
         then
            `wtoocytes`.`logm6`
         else
            NULL 
      end
   )),2) AS `wt_std_logm6_gly`,
round(avg(`wtoocytes`.`i`),2) AS `wt_avg_i`, 
round(stdev(`wtoocytes`.`i`),2) AS `wt_std_i` 
from
   `wtoocytes` 
group by
   `wtoocytes`.`Variant`, `wtoocytes`.`assay` ;

