DROP VIEW IF EXISTS oosummg;

CREATE  VIEW oosummg AS
SELECT * FROM
oosumvar
WHERE assay = 'mgDRC'
