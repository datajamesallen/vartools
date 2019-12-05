--
-- Structure for view `clinvarsumdna`
--
DROP VIEW IF EXISTS `clinvarsumdna`;

CREATE
 VIEW `clinvarsumdna` AS
SELECT
`clinvar_variant`.`Gene`,
`clinvar_variant`.Variant,
`clinvar_variant`.cDNA,
`clinvar_variant`.RefSeq,
`clinvar_variant`.aaNum,
`clinvar_variant`.`clinvar_DateCreated` AS clinvar_DateCreated,
count(DISTINCT `clinvar_obs`.`clinvar_ObsID`) AS clinvar_CountObs,
GROUP_CONCAT(replace(DISTINCT `clinvar_obs`.`clinvar_AlleleSource`,'',''), '/') AS  clinvar_AlleleSource,
GROUP_CONCAT(replace(DISTINCT `clinvar_obs`.`clinvar_TestingMethod`,'',''), '/') AS clinvar_TestingMethod,
GROUP_CONCAT(replace(DISTINCT `clinvar_obs`.`clinvar_OrgName`,'',''), '/') AS clinvar_OrgName,
GROUP_CONCAT(replace(DISTINCT `clinvar_obs_phen`.`clinvar_AffectedStatus`,'',''), '/') clinvar_AffectedStatus,
GROUP_CONCAT(replace(DISTINCT `clinvar_obs_phen`.`clinvar_Phenotype`,'',''), '/') AS clinvar_Phenotype
FROM `clinvar_variant`
LEFT JOIN
`clinvar_obs` ON
`clinvar_variant`.`clinvar_VariationID` = `clinvar_obs`.`clinvar_VariationID`
LEFT JOIN
`clinvar_obs_phen` ON
`clinvar_obs`.`clinvar_ObsID` = `clinvar_obs_phen`.`clinvar_ObsID`
AND
`clinvar_variant`.`clinvar_VariationID` = `clinvar_obs_phen`.`clinvar_VariationID`
GROUP BY
`clinvar_variant`.`cDNA`,`clinvar_variant`.`Variant`
