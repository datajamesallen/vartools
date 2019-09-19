--
-- Structure for view `clinvarsumobs`
--
DROP VIEW IF EXISTS `clinvarsumobs`;

CREATE 
 VIEW `clinvarsumobs` AS 
SELECT
`clinvar_variant`.*,
`clinvar_obs`.`clinvar_ObsID`,
`clinvar_obs`.`clinvar_AlleleSource`,
`clinvar_obs`.`clinvar_TestingMethod`,
`clinvar_obs`.`clinvar_OrgName`,
`clinvar_obs`.`clinvar_OrgID`,
GROUP_CONCAT(`clinvar_obs_phen`.`clinvar_AffectedStatus` , '|'),
GROUP_CONCAT(`clinvar_obs_phen`.`clinvar_Phenotype` , '|'),
GROUP_CONCAT(`clinvar_obs_phen`.`clinvar_PhenotypeID` , '|'),
GROUP_CONCAT(`clinvar_obs_phen`.`clinvar_phenXRefDB` , '|'),
GROUP_CONCAT(`clinvar_obs_phen`.`clinvar_phenXRefID` , '|')

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
`clinvar_obs`.`clinvar_ObsID`