DROP VIEW IF EXISTS `all_variants`;

CREATE 
 VIEW `all_variants` AS 
SELECT 
DISTINCT `gnomADv2.1.1`.Variant
FROM `gnomADv2.1.1`
UNION
SELECT
DISTINCT clinvarsumvar.Variant
FROM clinvarsumvar
UNION
SELECT
DISTINCT oosumvar.Variant
FROM oosumvar
GROUP BY
Variant

