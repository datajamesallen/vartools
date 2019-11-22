DROP VIEW IF EXISTS oosumglu;

CREATE  VIEW oosumglu AS
SELECT * FROM
oosumvar
WHERE assay = 'gluDRC'
