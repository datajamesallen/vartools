DROP VIEW IF EXISTS oosumgly;

CREATE  VIEW oosumgly AS
SELECT * FROM
oosumvar
WHERE assay = 'glyDRC'
