DROP VIEW IF EXISTS oosumph;

CREATE  VIEW oosumph AS
SELECT * FROM
oosumvar
WHERE assay = 'pH'
