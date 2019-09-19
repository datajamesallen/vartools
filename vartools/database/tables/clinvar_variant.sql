DROP TABLE `clinvar_variant`;
DROP TABLE `clinvar_obs`;
DROP TABLE `clinvar_obs_phen`;
DROP TABLE `clinvar_scv`;
DROP TABLE `clinvar_scv_phen`;

CREATE TABLE `clinvar_variant` (
    `Gene` varchar(6) DEFAULT NULL,
    `aaNum` integer DEFAULT NULL,
    `cDNA` varchar(36) DEFAULT NULL,
    `Protein` varchar(24) DEFAULT NULL,
    `Variant` varchar(16) DEFAULT NULL,
    `RefSeq` varchar(14) DEFAULT NULL,
    `clinvar_VariationID` integer PRIMARY KEY,
    `clinvar_VariationType` varchar(25) DEFAULT NULL,
    `clinvar_DateCreated` varchar(10) DEFAULT NULL
);
CREATE TABLE `clinvar_obs` (
    `clinvar_VariationID` integer DEFAULT NULL,
    `clinvar_ObsID` integer PRIMARY KEY,
    `clinvar_AlleleSource` varchar(14) DEFAULT NULL,
    `clinvar_TestingMethod` varchar(16) DEFAULT NULL,
    `clinvar_OrgName` varchar(133) DEFAULT NULL,
    `clinvar_OrgID` integer DEFUALT NULL
);
CREATE TABLE `clinvar_obs_phen` (
    `clinvar_VariationID` integer DEFAULT NULL,
    `clinvar_ObsID` integer DEFAULT NULL,
    `clinvar_AffectedStatus` varchar(14) DEFAULT NULL,
    `clinvar_Phenotype` varchar(100) DEFAULT NULL,
    `clinvar_PhenotypeID` integer DEFAULT NULL,
    `clinvar_phenXRefDB` varchar(6) DEFAULT NULL,
    `clinvar_phenXRefID` varchar(8) DEFAULT NULL
);
CREATE TABLE `clinvar_scv` (
    `clinvar_VariationID` integer DEFAULT NULL,
    `clinvar_scvID` varchar(12) PRIMARY KEY,
    `clinvar_Conclusion` varchar(22) DEFAULT NULL,
    `clinvar_Criteria` varchar(35) DEFAULT NULL,
    `clinvar_AlleleSource` varchar(12) DEFAULT NULL,
    `clinvar_TestingMethod` varchar(16) DEFAULT NULL,
    `clinvar_OrgName` varchar(133) DEFAULT NULL,
    `clinvar_OrgType` varchar(10) DEFAULT NULL,
    `clinvar_OrgID` integer DEFAULT NULL
);
CREATE TABLE `clinvar_scv_phen` (
    `clinvar_VariationID` integer DEFAULT NULL,
    `clinvar_scvID` varchar(21) DEFAULT NULL,
    `clinvar_Phenotype` varchar(100) DEFAULT NULL,
    `clinvar_PhenotypeID` integer DEFAULT NULL,
    `clinvar_phenXRefDB` varchar(6) DEFAULT NULL,
    `clinvar_phenXRefID` varchar(8) DEFAULT NULL
);

