DROP VIEW IF EXISTS oosumzn;

CREATE  VIEW oosumzn AS
SELECT * FROM
oosumvar
WHERE assay = 'znDRC'
