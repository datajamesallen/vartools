DROP VIEW IF EXISTS `all_variants`;

CREATE 
 VIEW `all_variants` AS 
SELECT 
DISTINCT gnomadv2.Variant
FROM gnomadv2
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

