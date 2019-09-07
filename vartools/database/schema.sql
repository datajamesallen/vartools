CREATE TABLE `cferv` (
  `Gene` varchar(6) DEFAULT NULL
,  `aaNum` integer DEFAULT NULL
,  `cDNA` varchar(18) DEFAULT NULL
,  `Protein` varchar(15) DEFAULT NULL
,  `Variant` varchar(14) DEFAULT NULL
,  `RefSeq` varchar(11) DEFAULT NULL
);
CREATE TABLE `gnomad_all` (
  `Gene` varchar(6) DEFAULT NULL
,  `aaNum` integer DEFAULT NULL
,  `cDNA` varchar(101) DEFAULT NULL
,  `Protein` varchar(29) DEFAULT NULL
,  `Variant` varchar(18) DEFAULT NULL
,  `RefSeq` varchar(18) DEFAULT NULL
,  `Chromosome` varchar(2) DEFAULT NULL
,  `Position` integer DEFAULT NULL
,  `rsID` varchar(12) DEFAULT NULL
,  `Reference` varchar(88) DEFAULT NULL
,  `Alternate` varchar(56) DEFAULT NULL
,  `Source` varchar(29) DEFAULT NULL
,  `Filters-exomes` varchar(4) DEFAULT NULL
,  `Filters-genomes` varchar(4) DEFAULT NULL
,  `Consequence` varchar(29) DEFAULT NULL
,  `Annotation` varchar(23) DEFAULT NULL
,  `Flags` varchar(15) DEFAULT NULL
,  `Allele_Count` integer DEFAULT NULL
,  `Allele_Number` integer DEFAULT NULL
,  `Allele_Frequency` decimal(43,19) DEFAULT NULL
,  `Homozygote_Count` integer DEFAULT NULL
,  `Hemizygote_Count` integer DEFAULT NULL
,  `Allele_Count_African` integer DEFAULT NULL
,  `Allele_Number_African` integer DEFAULT NULL
,  `Homozygote_Count_African` integer DEFAULT NULL
,  `Hemizygote_Count_African` integer DEFAULT NULL
,  `Allele_Count_Latino` integer DEFAULT NULL
,  `Allele_Number_Latino` integer DEFAULT NULL
,  `Homozygote_Count_Latino` integer DEFAULT NULL
,  `Hemizygote_Count_Latino` integer DEFAULT NULL
,  `Allele_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Allele_Number_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Homozygote_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Hemizygote_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Allele_Count_East_Asian` integer DEFAULT NULL
,  `Allele_Number_East_Asian` integer DEFAULT NULL
,  `Homozygote_Count_East_Asian` integer DEFAULT NULL
,  `Hemizygote_Count_East_Asian` integer DEFAULT NULL
,  `Allele_Count_European_(Finnish)` integer DEFAULT NULL
,  `Allele_Number_European_(Finnish)` integer DEFAULT NULL
,  `Homozygote_Count_European_(Finnish)` integer DEFAULT NULL
,  `Hemizygote_Count_European_(Finnish)` integer DEFAULT NULL
,  `Allele_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Allele_Number_European_(non-Finnish)` integer DEFAULT NULL
,  `Homozygote_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Hemizygote_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Allele_Count_Other` integer DEFAULT NULL
,  `Allele_Number_Other` integer DEFAULT NULL
,  `Homozygote_Count_Other` integer DEFAULT NULL
,  `Hemizygote_Count_Other` integer DEFAULT NULL
,  `Allele_Count_South_Asian` integer DEFAULT NULL
,  `Allele_Number_South_Asian` integer DEFAULT NULL
,  `Homozygote_Count_South_Asian` integer DEFAULT NULL
,  `Hemizygote_Count_South_Asian` integer DEFAULT NULL
);
CREATE TABLE `gnomad_controls` (
  `Gene` varchar(6) DEFAULT NULL
,  `aaNum` integer DEFAULT NULL
,  `cDNA` varchar(101) DEFAULT NULL
,  `Protein` varchar(29) DEFAULT NULL
,  `Variant` varchar(18) DEFAULT NULL
,  `RefSeq` varchar(18) DEFAULT NULL
,  `Chromosome` varchar(2) DEFAULT NULL
,  `Position` integer DEFAULT NULL
,  `rsID` varchar(12) DEFAULT NULL
,  `Reference` varchar(88) DEFAULT NULL
,  `Alternate` varchar(54) DEFAULT NULL
,  `Source` varchar(29) DEFAULT NULL
,  `Filters-exomes` varchar(4) DEFAULT NULL
,  `Filters-genomes` varchar(4) DEFAULT NULL
,  `Consequence` varchar(29) DEFAULT NULL
,  `Annotation` varchar(23) DEFAULT NULL
,  `Flags` varchar(15) DEFAULT NULL
,  `Allele_Count` integer DEFAULT NULL
,  `Allele_Number` integer DEFAULT NULL
,  `Allele_Frequency` decimal(42,19) DEFAULT NULL
,  `Homozygote_Count` integer DEFAULT NULL
,  `Hemizygote_Count` integer DEFAULT NULL
,  `Allele_Count_African` integer DEFAULT NULL
,  `Allele_Number_African` integer DEFAULT NULL
,  `Homozygote_Count_African` integer DEFAULT NULL
,  `Hemizygote_Count_African` integer DEFAULT NULL
,  `Allele_Count_Latino` integer DEFAULT NULL
,  `Allele_Number_Latino` integer DEFAULT NULL
,  `Homozygote_Count_Latino` integer DEFAULT NULL
,  `Hemizygote_Count_Latino` integer DEFAULT NULL
,  `Allele_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Allele_Number_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Homozygote_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Hemizygote_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Allele_Count_East_Asian` integer DEFAULT NULL
,  `Allele_Number_East_Asian` integer DEFAULT NULL
,  `Homozygote_Count_East_Asian` integer DEFAULT NULL
,  `Hemizygote_Count_East_Asian` integer DEFAULT NULL
,  `Allele_Count_European_(Finnish)` integer DEFAULT NULL
,  `Allele_Number_European_(Finnish)` integer DEFAULT NULL
,  `Homozygote_Count_European_(Finnish)` integer DEFAULT NULL
,  `Hemizygote_Count_European_(Finnish)` integer DEFAULT NULL
,  `Allele_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Allele_Number_European_(non-Finnish)` integer DEFAULT NULL
,  `Homozygote_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Hemizygote_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Allele_Count_Other` integer DEFAULT NULL
,  `Allele_Number_Other` integer DEFAULT NULL
,  `Homozygote_Count_Other` integer DEFAULT NULL
,  `Hemizygote_Count_Other` integer DEFAULT NULL
,  `Allele_Count_South_Asian` integer DEFAULT NULL
,  `Allele_Number_South_Asian` integer DEFAULT NULL
,  `Homozygote_Count_South_Asian` integer DEFAULT NULL
,  `Hemizygote_Count_South_Asian` integer DEFAULT NULL
);
CREATE TABLE `gnomad_noncancer` (
  `Gene` varchar(6) DEFAULT NULL
,  `aaNum` integer DEFAULT NULL
,  `cDNA` varchar(101) DEFAULT NULL
,  `Protein` varchar(29) DEFAULT NULL
,  `Variant` varchar(18) DEFAULT NULL
,  `RefSeq` varchar(18) DEFAULT NULL
,  `Chromosome` varchar(2) DEFAULT NULL
,  `Position` integer DEFAULT NULL
,  `rsID` varchar(12) DEFAULT NULL
,  `Reference` varchar(88) DEFAULT NULL
,  `Alternate` varchar(56) DEFAULT NULL
,  `Source` varchar(29) DEFAULT NULL
,  `Filters-exomes` varchar(4) DEFAULT NULL
,  `Filters-genomes` varchar(4) DEFAULT NULL
,  `Consequence` varchar(29) DEFAULT NULL
,  `Annotation` varchar(23) DEFAULT NULL
,  `Flags` varchar(15) DEFAULT NULL
,  `Allele_Count` integer DEFAULT NULL
,  `Allele_Number` integer DEFAULT NULL
,  `Allele_Frequency` decimal(43,19) DEFAULT NULL
,  `Homozygote_Count` integer DEFAULT NULL
,  `Hemizygote_Count` integer DEFAULT NULL
,  `Allele_Count_African` integer DEFAULT NULL
,  `Allele_Number_African` integer DEFAULT NULL
,  `Homozygote_Count_African` integer DEFAULT NULL
,  `Hemizygote_Count_African` integer DEFAULT NULL
,  `Allele_Count_Latino` integer DEFAULT NULL
,  `Allele_Number_Latino` integer DEFAULT NULL
,  `Homozygote_Count_Latino` integer DEFAULT NULL
,  `Hemizygote_Count_Latino` integer DEFAULT NULL
,  `Allele_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Allele_Number_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Homozygote_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Hemizygote_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Allele_Count_East_Asian` integer DEFAULT NULL
,  `Allele_Number_East_Asian` integer DEFAULT NULL
,  `Homozygote_Count_East_Asian` integer DEFAULT NULL
,  `Hemizygote_Count_East_Asian` integer DEFAULT NULL
,  `Allele_Count_European_(Finnish)` integer DEFAULT NULL
,  `Allele_Number_European_(Finnish)` integer DEFAULT NULL
,  `Homozygote_Count_European_(Finnish)` integer DEFAULT NULL
,  `Hemizygote_Count_European_(Finnish)` integer DEFAULT NULL
,  `Allele_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Allele_Number_European_(non-Finnish)` integer DEFAULT NULL
,  `Homozygote_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Hemizygote_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Allele_Count_Other` integer DEFAULT NULL
,  `Allele_Number_Other` integer DEFAULT NULL
,  `Homozygote_Count_Other` integer DEFAULT NULL
,  `Hemizygote_Count_Other` integer DEFAULT NULL
,  `Allele_Count_South_Asian` integer DEFAULT NULL
,  `Allele_Number_South_Asian` integer DEFAULT NULL
,  `Homozygote_Count_South_Asian` integer DEFAULT NULL
,  `Hemizygote_Count_South_Asian` integer DEFAULT NULL
);
CREATE TABLE `gnomad_nonneuro` (
  `Gene` varchar(6) DEFAULT NULL
,  `aaNum` integer DEFAULT NULL
,  `cDNA` varchar(101) DEFAULT NULL
,  `Protein` varchar(29) DEFAULT NULL
,  `Variant` varchar(18) DEFAULT NULL
,  `RefSeq` varchar(18) DEFAULT NULL
,  `Chromosome` varchar(2) DEFAULT NULL
,  `Position` integer DEFAULT NULL
,  `rsID` varchar(12) DEFAULT NULL
,  `Reference` varchar(88) DEFAULT NULL
,  `Alternate` varchar(56) DEFAULT NULL
,  `Source` varchar(29) DEFAULT NULL
,  `Filters-exomes` varchar(4) DEFAULT NULL
,  `Filters-genomes` varchar(4) DEFAULT NULL
,  `Consequence` varchar(29) DEFAULT NULL
,  `Annotation` varchar(23) DEFAULT NULL
,  `Flags` varchar(15) DEFAULT NULL
,  `Allele_Count` integer DEFAULT NULL
,  `Allele_Number` integer DEFAULT NULL
,  `Allele_Frequency` decimal(43,19) DEFAULT NULL
,  `Homozygote_Count` integer DEFAULT NULL
,  `Hemizygote_Count` integer DEFAULT NULL
,  `Allele_Count_African` integer DEFAULT NULL
,  `Allele_Number_African` integer DEFAULT NULL
,  `Homozygote_Count_African` integer DEFAULT NULL
,  `Hemizygote_Count_African` integer DEFAULT NULL
,  `Allele_Count_Latino` integer DEFAULT NULL
,  `Allele_Number_Latino` integer DEFAULT NULL
,  `Homozygote_Count_Latino` integer DEFAULT NULL
,  `Hemizygote_Count_Latino` integer DEFAULT NULL
,  `Allele_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Allele_Number_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Homozygote_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Hemizygote_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Allele_Count_East_Asian` integer DEFAULT NULL
,  `Allele_Number_East_Asian` integer DEFAULT NULL
,  `Homozygote_Count_East_Asian` integer DEFAULT NULL
,  `Hemizygote_Count_East_Asian` integer DEFAULT NULL
,  `Allele_Count_European_(Finnish)` integer DEFAULT NULL
,  `Allele_Number_European_(Finnish)` integer DEFAULT NULL
,  `Homozygote_Count_European_(Finnish)` integer DEFAULT NULL
,  `Hemizygote_Count_European_(Finnish)` integer DEFAULT NULL
,  `Allele_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Allele_Number_European_(non-Finnish)` integer DEFAULT NULL
,  `Homozygote_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Hemizygote_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Allele_Count_Other` integer DEFAULT NULL
,  `Allele_Number_Other` integer DEFAULT NULL
,  `Homozygote_Count_Other` integer DEFAULT NULL
,  `Hemizygote_Count_Other` integer DEFAULT NULL
,  `Allele_Count_South_Asian` integer DEFAULT NULL
,  `Allele_Number_South_Asian` integer DEFAULT NULL
,  `Homozygote_Count_South_Asian` integer DEFAULT NULL
,  `Hemizygote_Count_South_Asian` integer DEFAULT NULL
);
CREATE TABLE `gnomad_nontopmed` (
  `Gene` varchar(6) DEFAULT NULL
,  `aaNum` integer DEFAULT NULL
,  `cDNA` varchar(101) DEFAULT NULL
,  `Protein` varchar(29) DEFAULT NULL
,  `Variant` varchar(18) DEFAULT NULL
,  `RefSeq` varchar(18) DEFAULT NULL
,  `Chromosome` varchar(2) DEFAULT NULL
,  `Position` integer DEFAULT NULL
,  `rsID` varchar(12) DEFAULT NULL
,  `Reference` varchar(88) DEFAULT NULL
,  `Alternate` varchar(56) DEFAULT NULL
,  `Source` varchar(29) DEFAULT NULL
,  `Filters-exomes` varchar(4) DEFAULT NULL
,  `Filters-genomes` varchar(4) DEFAULT NULL
,  `Consequence` varchar(29) DEFAULT NULL
,  `Annotation` varchar(23) DEFAULT NULL
,  `Flags` varchar(15) DEFAULT NULL
,  `Allele_Count` integer DEFAULT NULL
,  `Allele_Number` integer DEFAULT NULL
,  `Allele_Frequency` decimal(43,19) DEFAULT NULL
,  `Homozygote_Count` integer DEFAULT NULL
,  `Hemizygote_Count` integer DEFAULT NULL
,  `Allele_Count_African` integer DEFAULT NULL
,  `Allele_Number_African` integer DEFAULT NULL
,  `Homozygote_Count_African` integer DEFAULT NULL
,  `Hemizygote_Count_African` integer DEFAULT NULL
,  `Allele_Count_Latino` integer DEFAULT NULL
,  `Allele_Number_Latino` integer DEFAULT NULL
,  `Homozygote_Count_Latino` integer DEFAULT NULL
,  `Hemizygote_Count_Latino` integer DEFAULT NULL
,  `Allele_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Allele_Number_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Homozygote_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Hemizygote_Count_Ashkenazi_Jewish` integer DEFAULT NULL
,  `Allele_Count_East_Asian` integer DEFAULT NULL
,  `Allele_Number_East_Asian` integer DEFAULT NULL
,  `Homozygote_Count_East_Asian` integer DEFAULT NULL
,  `Hemizygote_Count_East_Asian` integer DEFAULT NULL
,  `Allele_Count_European_(Finnish)` integer DEFAULT NULL
,  `Allele_Number_European_(Finnish)` integer DEFAULT NULL
,  `Homozygote_Count_European_(Finnish)` integer DEFAULT NULL
,  `Hemizygote_Count_European_(Finnish)` integer DEFAULT NULL
,  `Allele_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Allele_Number_European_(non-Finnish)` integer DEFAULT NULL
,  `Homozygote_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Hemizygote_Count_European_(non-Finnish)` integer DEFAULT NULL
,  `Allele_Count_Other` integer DEFAULT NULL
,  `Allele_Number_Other` integer DEFAULT NULL
,  `Homozygote_Count_Other` integer DEFAULT NULL
,  `Hemizygote_Count_Other` integer DEFAULT NULL
,  `Allele_Count_South_Asian` integer DEFAULT NULL
,  `Allele_Number_South_Asian` integer DEFAULT NULL
,  `Homozygote_Count_South_Asian` integer DEFAULT NULL
,  `Hemizygote_Count_South_Asian` integer DEFAULT NULL
);
CREATE TABLE `info_grin1` (
  `aaNum` integer DEFAULT NULL
,  `aaRes` varchar(4) DEFAULT NULL
,  `cDNAbase` integer DEFAULT NULL
,  `RefSeqNuc` integer DEFAULT NULL
,  `Exon` varchar(18) DEFAULT NULL
,  `Codon` varchar(3) DEFAULT NULL
,  `Domain` varchar(13) DEFAULT NULL
);
CREATE TABLE `info_grin2b` (
  `aaNum` integer DEFAULT NULL
,  `aaRes` varchar(4) DEFAULT NULL
,  `cDNAbase` integer DEFAULT NULL
,  `RefSeqNuc` integer DEFAULT NULL
,  `Exon` varchar(20) DEFAULT NULL
,  `Codon` varchar(3) DEFAULT NULL
,  `Domain` varchar(13) DEFAULT NULL
);
CREATE TABLE `info_grin2a` (
  `aaNum` integer DEFAULT NULL
,  `aaRes` varchar(4) DEFAULT NULL
,  `cDNAbase` integer DEFAULT NULL
,  `RefSeqNuc` integer DEFAULT NULL
,  `Exon` varchar(20) DEFAULT NULL
,  `Codon` varchar(3) DEFAULT NULL
,  `Domain` varchar(13) DEFAULT NULL
);
CREATE TABLE `jpalist` (
  `variant` varchar(9) DEFAULT NULL
);
CREATE TABLE `lemke` (
  `Gene` varchar(6) DEFAULT NULL
,  `aaNum` integer DEFAULT NULL
,  `cDNA` varchar(21) DEFAULT NULL
,  `Protein` varchar(20) DEFAULT NULL
,  `Variant` varchar(16) DEFAULT NULL
,  `RefSeq` varchar(11) DEFAULT NULL
,  `lemke_ID` integer DEFAULT NULL
,  `lemke_Zygosity` varchar(12) DEFAULT NULL
,  `lemke_AlleleSource` varchar(19) DEFAULT NULL
,  `lemke_SeqMethod` varchar(12) DEFAULT NULL
,  `lemke_YearSeq` integer DEFAULT NULL
,  `lemke_Sex` varchar(6) DEFAULT NULL
,  `lemke_PubMedID` varchar(8) DEFAULT NULL
,  `lemke_FirstAuthor` varchar(13) DEFAULT NULL
,  `lemke_YearPublished` integer DEFAULT NULL
,  `lemke_DevDelay` varchar(23) DEFAULT NULL
,  `lemke_Seizures` varchar(3) DEFAULT NULL
);
CREATE TABLE `sequencing_complete` (
  `Variant` varchar(14) DEFAULT NULL
);
CREATE TABLE `topmed` (
  `Gene` varchar(6) DEFAULT NULL
,  `aaNum` integer DEFAULT NULL
,  `cDNA` varchar(42) DEFAULT NULL
,  `Protein` varchar(38) DEFAULT NULL
,  `Variant` varchar(18) DEFAULT NULL
,  `RefSeq` varchar(17) DEFAULT NULL
,  `topmed_VariantType` varchar(18) DEFAULT NULL
,  `topmed_AlleleCount` integer DEFAULT NULL
,  `topmed_AlleleNum` integer DEFAULT NULL
,  `topmed_AlleleFreq` decimal(10,9) DEFAULT NULL
,  `topmed_GenomicPos` integer DEFAULT NULL
,  `topmed_Rsid` varchar(11) DEFAULT NULL
);
CREATE TABLE `varoocytes` (
  `Variant` varchar(255) DEFAULT NULL
,  `file` char(25) NOT NULL
,  `glun1` varchar(25) NOT NULL
,  `glun2` varchar(25) NOT NULL
,  `i` integer DEFAULT NULL
,  `pH_per_inhib` decimal(4,1) DEFAULT NULL
,  `logm10` decimal(4,1) DEFAULT NULL
,  `logm9p5` decimal(4,1) DEFAULT NULL
,  `logm9` decimal(4,1) DEFAULT NULL
,  `logm8p5` decimal(4,1) DEFAULT NULL
,  `logm8` decimal(4,1) DEFAULT NULL
,  `logm7p5` decimal(4,1) DEFAULT NULL
,  `logm7` decimal(4,1) DEFAULT NULL
,  `logm6p5` decimal(4,1) DEFAULT NULL
,  `logm6` decimal(4,1) DEFAULT NULL
,  `logm5p5` decimal(4,1) DEFAULT NULL
,  `logm5` decimal(4,1) DEFAULT NULL
,  `logm4p5` decimal(4,1) DEFAULT NULL
,  `logm4` decimal(4,1) DEFAULT NULL
,  `logm3p5` decimal(4,1) DEFAULT NULL
,  `logm3` decimal(4,1) DEFAULT NULL
,  `logm2p5` decimal(4,1) DEFAULT NULL
,  `logm2` decimal(4,1) DEFAULT NULL
,  `logm1p5` decimal(4,1) DEFAULT NULL
,  `logm1` decimal(4,1) DEFAULT NULL
,  `notes` mediumtext DEFAULT NULL
,  `dbinfo` char(4) DEFAULT NULL
,  `logec50` float(200,14) DEFAULT NULL
,  `hillslope` float(200,14) DEFAULT NULL
,  `ymin` float(200,14) DEFAULT NULL
,  `ymax` float(200,14) DEFAULT NULL
,  `equation` varchar(100) DEFAULT NULL
,  `conv` char(5) DEFAULT NULL
,  `assay` varchar(255) DEFAULT NULL
,  `date_inj` date DEFAULT NULL
,  `date_rec` date DEFAULT NULL
,  `vhold` integer DEFAULT NULL
,  `coagonist` varchar(255) DEFAULT NULL
,  `phsol` varchar(255) DEFAULT NULL
,  `drug_id` varchar(255) DEFAULT NULL
,  `rig` char(3) DEFAULT NULL
,  `initials` char(3) DEFAULT NULL
,  `experiment_info` mediumtext DEFAULT NULL
,  `upload_time` timestamp NOT NULL DEFAULT current_timestamp 
,  PRIMARY KEY (`file`)
);
CREATE TABLE `wtoocytes` (
  `Variant` varchar(255) NOT NULL
,  `file` char(25) NOT NULL
,  `glun1` varchar(25) NOT NULL
,  `glun2` varchar(25) NOT NULL
,  `i` integer DEFAULT NULL
,  `pH_per_inhib` decimal(4,1) DEFAULT NULL
,  `logm10` decimal(4,1) DEFAULT NULL
,  `logm9p5` decimal(4,1) DEFAULT NULL
,  `logm9` decimal(4,1) DEFAULT NULL
,  `logm8p5` decimal(4,1) DEFAULT NULL
,  `logm8` decimal(4,1) DEFAULT NULL
,  `logm7p5` decimal(4,1) DEFAULT NULL
,  `logm7` decimal(4,1) DEFAULT NULL
,  `logm6p5` decimal(4,1) DEFAULT NULL
,  `logm6` decimal(4,1) DEFAULT NULL
,  `logm5p5` decimal(4,1) DEFAULT NULL
,  `logm5` decimal(4,1) DEFAULT NULL
,  `logm4p5` decimal(4,1) DEFAULT NULL
,  `logm4` decimal(4,1) DEFAULT NULL
,  `logm3p5` decimal(4,1) DEFAULT NULL
,  `logm3` decimal(4,1) DEFAULT NULL
,  `logm2p5` decimal(4,1) DEFAULT NULL
,  `logm2` decimal(4,1) DEFAULT NULL
,  `logm1p5` decimal(4,1) DEFAULT NULL
,  `logm1` decimal(4,1) DEFAULT NULL
,  `notes` mediumtext DEFAULT NULL
,  `dbinfo` char(4) DEFAULT NULL
,  `logec50` float(200,14) DEFAULT NULL
,  `hillslope` float(200,14) DEFAULT NULL
,  `ymin` float(200,14) DEFAULT NULL
,  `ymax` float(200,14) DEFAULT NULL
,  `equation` varchar(100) DEFAULT NULL
,  `conv` char(5) DEFAULT NULL
,  `assay` varchar(255) DEFAULT NULL
,  `date_inj` date DEFAULT NULL
,  `date_rec` date DEFAULT NULL
,  `vhold` integer DEFAULT NULL
,  `coagonist` varchar(255) DEFAULT NULL
,  `phsol` varchar(255) DEFAULT NULL
,  `drug_id` varchar(255) DEFAULT NULL
,  `rig` char(3) DEFAULT NULL
,  `initials` char(3) DEFAULT NULL
,  `experiment_info` mediumtext DEFAULT NULL
,  `upload_time` timestamp NOT NULL DEFAULT current_timestamp 
,  PRIMARY KEY (`Variant`,`file`)
);
CREATE INDEX "idx_varoocytes_Variant" ON "varoocytes" (`Variant`);
CREATE INDEX "idx_gnomad_nonneuro_Variant" ON "gnomad_nonneuro" (`Variant`);
CREATE INDEX "idx_topmed_Variant" ON "topmed" (`Variant`);
CREATE INDEX "idx_gnomad_all_Variant" ON "gnomad_all" (`Variant`);
CREATE INDEX "idx_lemke_Variant" ON "lemke" (`Variant`);
CREATE INDEX "idx_cferv_Variant" ON "cferv" (`Variant`);
CREATE VIEW `clinvarsumobs` AS 
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
/* clinvarsumobs(Gene,aaNum,cDNA,Protein,Variant,RefSeq,clinvar_VariationID,clinvar_VariationType,clinvar_DateCreated,clinvar_ObsID,clinvar_AlleleSource,clinvar_TestingMethod,clinvar_OrgName,clinvar_OrgID,"GROUP_CONCAT(`clinvar_obs_phen`.`clinvar_AffectedStatus` , '|')","GROUP_CONCAT(`clinvar_obs_phen`.`clinvar_Phenotype` , '|')","GROUP_CONCAT(`clinvar_obs_phen`.`clinvar_PhenotypeID` , '|')","GROUP_CONCAT(`clinvar_obs_phen`.`clinvar_phenXRefDB` , '|')","GROUP_CONCAT(`clinvar_obs_phen`.`clinvar_phenXRefID` , '|')") */;
CREATE VIEW `human_variants` AS 
select
   `cferv`.`Gene` AS `Gene`,
   `cferv`.`aaNum` AS `aaNum`,
   `cferv`.`cDNA` AS `cDNA`,
   `cferv`.`Protein` AS `Protein`,
   `cferv`.`Variant` AS `Variant`,
   `cferv`.`RefSeq` AS `RefSeq`,
   'cferv' AS `datasource` 
from
   `cferv` 
union
select
   `clinvar_variant`.`Gene` AS `Gene`,
   `clinvar_variant`.`aaNum` AS `aaNum`,
   `clinvar_variant`.`cDNA` AS `cDNA`,
   `clinvar_variant`.`Protein` AS `Protein`,
   `clinvar_variant`.`Variant` AS `Variant`,
   `clinvar_variant`.`RefSeq` AS `RefSeq`,
   'clinvar' AS `datasource` 
from
   `clinvar_variant` 
union
select
   `gnomad_all`.`Gene` AS `Gene`,
   `gnomad_all`.`aaNum` AS `aaNum`,
   `gnomad_all`.`cDNA` AS `cDNA`,
   `gnomad_all`.`Protein` AS `Protein`,
   `gnomad_all`.`Variant` AS `Variant`,
   `gnomad_all`.`RefSeq` AS `RefSeq`,
   'gnomad' AS `datasource`
from
   `gnomad_all` 
union
select
   `topmed`.`Gene` AS `Gene`,
   `topmed`.`aaNum` AS `aaNum`,
   `topmed`.`cDNA` AS `cDNA`,
   `topmed`.`Protein` AS `Protein`,
   `topmed`.`Variant` AS `Variant`,
   `topmed`.`RefSeq` AS `RefSeq`,
   'topmed' AS `datasource` 
from
   `topmed` 
union
select
   `lemke`.`Gene` AS `Gene`,
   `lemke`.`aaNum` AS `aaNum`,
   `lemke`.`cDNA` AS `cDNA`,
   `lemke`.`Protein` AS `Protein`,
   `lemke`.`Variant` AS `Variant`,
   `lemke`.`RefSeq` AS `RefSeq`,
   'lemke' AS `datasource`
from
   `lemke`
/* human_variants(Gene,aaNum,cDNA,Protein,Variant,RefSeq,datasource) */;
CREATE VIEW oosumglu AS
SELECT * FROM
oosumvar
WHERE assay = 'gluDRC';
CREATE VIEW oosumgly AS
SELECT * FROM
oosumvar
WHERE assay = 'glyDRC';
CREATE VIEW oosummg AS
SELECT * FROM
oosumvar
WHERE assay = 'mgDRC';
CREATE VIEW oosumph AS
SELECT * FROM
oosumvar
WHERE assay = 'pH';
CREATE VIEW `oosumvar` AS 
select
varoosumvar.Variant as Variant,
varoosumvar.assay as assay,
varoosumvar.var_glun1,
varoosumvar.var_glun2,
wtoosumvar.wt_glun1,
wtoosumvar.wt_glun2,
wtoosumvar.wt_n_oocytes,
wtoosumvar.wt_n_fit,
varoosumvar.var_n_oocytes,
varoosumvar.var_n_fit,
varoosumvar.var_date_rec_count,
wtoosumvar.wt_date_rec_count,
varoosumvar.var_avg_logec50,
varoosumvar.var_std_logec50,
wtoosumvar.wt_avg_logec50,
wtoosumvar.wt_std_logec50,
varoosumvar.var_avg_hillslope,
varoosumvar.var_std_hillslope,
wtoosumvar.wt_avg_hillslope,
wtoosumvar.wt_std_hillslope,
varoosumvar.var_avg_ymin,
varoosumvar.var_std_ymin,
wtoosumvar.wt_avg_ymin,
wtoosumvar.wt_std_ymin,
varoosumvar.var_avg_ymax,
varoosumvar.var_std_ymax,
wtoosumvar.wt_avg_ymax,
wtoosumvar.wt_std_ymax,
varoosumvar.var_avg_pH_per_inhib,
varoosumvar.var_std_pH_per_inhib,
wtoosumvar.wt_avg_pH_per_inhib,
wtoosumvar.wt_std_pH_per_inhib,
varoosumvar.var_avg_logm4p5_mg,
varoosumvar.var_std_logm4p5_mg,
wtoosumvar.wt_avg_logm4p5_mg,
wtoosumvar.wt_std_logm4p5_mg,
varoosumvar.var_avg_logm8_zn,
varoosumvar.var_std_logm8_zn,
wtoosumvar.wt_avg_logm8_zn,
wtoosumvar.wt_std_logm8_zn,
varoosumvar.var_avg_logm6p5_zn,
varoosumvar.var_std_logm6p5_zn,
wtoosumvar.wt_avg_logm6p5_zn,
wtoosumvar.wt_std_logm6p5_zn,
varoosumvar.var_avg_logm5p5_glu,
varoosumvar.var_std_logm5p5_glu,
wtoosumvar.wt_avg_logm5p5_glu,
wtoosumvar.wt_std_logm5p5_glu,
varoosumvar.var_avg_logm6_gly,
varoosumvar.var_std_logm6_gly,
wtoosumvar.wt_avg_logm6_gly,
wtoosumvar.wt_std_logm6_gly,
varoosumvar.var_avg_i,
varoosumvar.var_std_i,
wtoosumvar.wt_avg_i,
wtoosumvar.wt_std_i
from varoosumvar
left join
wtoosumvar
on varoosumvar.Variant = wtoosumvar.Variant and varoosumvar.assay = wtoosumvar.assay;
CREATE VIEW oosumzn AS
SELECT * FROM
oosumvar
WHERE assay = 'znDRC';
CREATE VIEW `summary` AS 
select 
human_variants_sumvar.Gene,
human_variants_sumvar.aaNum,
human_variants_sumvar.cDNA,
human_variants_sumvar.Protein,
human_variants_sumvar.Variant,
human_variants_sumvar.RefSeq,
gnomadsumvar.gnomad_all_AlleleCount,
gnomadsumvar.gnomad_all_AlleleNum,
gnomadsumvar.gnomad_controls_AlleleCount,
gnomadsumvar.gnomad_controls_AlleleNum,
gnomadsumvar.gnomad_nonneuro_AlleleCount,
gnomadsumvar.gnomad_nonneuro_AlleleNum,
gnomadsumvar.gnomad_nontopmed_AlleleCount,
gnomadsumvar.gnomad_nontopmed_AlleleNum,
clinvarsumvar.clinvar_CountObs,
clinvarsumvar.clinvar_DateCreated,
clinvarsumvar.clinvar_AlleleSource,
clinvarsumvar.clinvar_TestingMethod,
clinvarsumvar.clinvar_OrgName,
clinvarsumvar.clinvar_AffectedStatus,
clinvarsumvar.clinvar_Phenotype,
lemkesumvar.lemke_Count,
lemkesumvar.lemke_Zygosity,
lemkesumvar.lemke_AlleleSource,
lemkesumvar.lemke_Sex,
lemkesumvar.lemke_Seq,
lemkesumvar.lemke_Pubmed,
lemkesumvar.lemke_DevDelay,
lemkesumvar.lemke_Seizures,
topmedsumvar.topmed_AlleleCount AS count_TOPMed,
topmedsumvar.topmed_AlleleNum AS denom_TOPMed,
/*--Glutamate*/
/*--wt*/
oosumglu.wt_n_oocytes as wt_n_rec_glu,
oosumglu.wt_n_fit as wt_n_fit_glu,
oosumglu.wt_date_rec_count as wt_n_date_glu,
oosumglu.wt_avg_logec50 as wt_avg_logEC50_glu,
oosumglu.wt_std_logec50 as wt_std_logEC50_glu,
oosumglu.wt_avg_hillslope as wt_avg_hillslope_glu,
oosumglu.wt_std_hillslope as wt_std_hillslope_glu,
oosumglu.wt_avg_ymin as wt_avg_ymin_glu,
oosumglu.wt_std_ymin as wt_std_ymin_glu,
oosumglu.wt_avg_ymax as wt_avg_ymax_glu,
oosumglu.wt_std_ymax as wt_std_ymax_glu,
oosumglu.wt_avg_logm5p5_glu,
oosumglu.wt_std_logm5p5_glu,
oosumglu.wt_avg_i as wt_avg_i_glu,
oosumglu.wt_std_i as wt_std_i_glu,

/*--var*/
oosumglu.var_n_oocytes as var_n_rec_glu,
oosumglu.var_n_fit as var_n_fit_glu,
oosumglu.var_date_rec_count as var_n_date_glu,
oosumglu.var_avg_logec50 as var_avg_logEC50_glu,
oosumglu.var_std_logec50 as var_std_logEC50_glu,
oosumglu.var_avg_hillslope as var_avg_hillslope_glu,
oosumglu.var_std_hillslope as var_std_hillslope_glu,
oosumglu.var_avg_ymin as var_avg_ymin_glu,
oosumglu.var_std_ymin as var_std_ymin_glu,
oosumglu.var_avg_ymax as var_avg_ymax_glu,
oosumglu.var_std_ymax as var_std_ymax_glu,
oosumglu.var_avg_logm5p5_glu,
oosumglu.var_std_logm5p5_glu,
oosumglu.var_avg_i as var_avg_i_glu,
oosumglu.var_std_i as var_std_i_glu,
/*--Glycine*/
/*--wt*/
oosumgly.wt_n_oocytes as wt_n_rec_gly,
oosumgly.wt_n_fit as wt_n_fit_gly,
oosumgly.wt_date_rec_count as wt_n_frogs_gly,
oosumgly.wt_avg_logec50 as wt_avg_logEC50_gly,
oosumgly.wt_std_logec50 as wt_std_logEC50_gly,
oosumgly.wt_avg_hillslope as wt_avg_hillslope_gly,
oosumgly.wt_std_hillslope as wt_std_hillslope_gly,
oosumgly.wt_avg_ymin as wt_avg_ymin_gly,
oosumgly.wt_std_ymin as wt_std_ymin_gly,
oosumgly.wt_avg_ymax as wt_avg_ymax_gly,
oosumgly.wt_std_ymax as wt_std_ymax_gly,
oosumgly.wt_avg_logm6_gly,
oosumgly.wt_std_logm6_gly,
oosumgly.wt_avg_i as wt_avg_i_gly,
oosumgly.wt_std_i as wt_std_i_gly,
/*--var*/
oosumgly.var_n_oocytes as var_n_rec_gly,
oosumgly.var_n_fit as var_n_fit_gly,
oosumgly.var_date_rec_count as var_n_date_gly,
oosumgly.var_avg_logec50 as var_avg_logEC50_gly,
oosumgly.var_std_logec50 as var_std_logEC50_gly,
oosumgly.var_avg_hillslope as var_avg_hillslope_gly,
oosumgly.var_std_hillslope as var_std_hillslope_gly,
oosumgly.var_avg_ymin as var_avg_ymin_gly,
oosumgly.var_std_ymin as var_std_ymin_gly,
oosumgly.var_avg_ymax as var_avg_ymax_gly,
oosumgly.var_std_ymax as var_std_ymax_gly,
oosumgly.var_avg_logm6_gly,
oosumgly.var_std_logm6_gly,
oosumgly.var_avg_i as var_avg_i_gly,
oosumgly.var_std_i as var_std_i_gly,
/*--pH*/
/*--wt*/
oosumph.wt_n_oocytes as wt_n_rec_ph,
oosumph.wt_date_rec_count as wt_n_date_ph,
oosumph.wt_avg_pH_per_inhib as wt_avg_logm6p8_ph,
oosumph.wt_std_pH_per_inhib as wt_std_logm6p8_ph,
oosumph.wt_avg_i as wt_avg_i_ph,
oosumph.wt_std_i as wt_std_i_ph,
/*--var*/
oosumph.var_n_oocytes as var_n_rec_ph,
oosumph.var_date_rec_count as var_n_date_ph,
oosumph.var_avg_pH_per_inhib as var_avg_logm6p8_ph,
oosumph.var_std_pH_per_inhib as var_std_logm6p8_ph,
oosumph.var_avg_i as var_avg_i_ph,
oosumph.var_std_i as var_std_i_ph,
/*--Magnesium*/
/*--wt*/
oosummg.wt_n_oocytes as wt_n_rec_mg,
oosummg.wt_n_fit as wt_n_fit_mg,
oosummg.wt_date_rec_count as wt_n_date_mg,
oosummg.wt_avg_logec50 as wt_avg_logIC50_mg,
oosummg.wt_std_logec50 as wt_std_logIC50_mg,
oosummg.wt_avg_hillslope as wt_avg_hillslope_mg,
oosummg.wt_std_hillslope as wt_std_hillslope_mg,
oosummg.wt_avg_ymin as wt_avg_ymin_mg,
oosummg.wt_std_ymin as wt_std_ymin_mg,
oosummg.wt_avg_ymax as wt_avg_ymax_mg,
oosummg.wt_std_ymax as wt_std_ymax_mg,
oosummg.wt_avg_logm4p5_mg,
oosummg.wt_std_logm4p5_mg,
oosummg.wt_avg_i as wt_avg_i_mg,
oosummg.wt_std_i as wt_std_i_mg,
/*--var*/
oosummg.var_n_oocytes as var_n_rec_mg,
oosummg.var_n_fit as var_n_fit_mg,
oosummg.var_date_rec_count as var_n_date_mg,
oosummg.var_avg_logec50 as var_avg_logIC50_mg,
oosummg.var_std_logec50 as var_std_logIC50_mg,
oosummg.var_avg_hillslope as var_avg_hillslope_mg,
oosummg.var_std_hillslope as var_std_hillslope_mg,
oosummg.var_avg_ymin as var_avg_ymin_mg,
oosummg.var_std_ymin as var_std_ymin_mg,
oosummg.var_avg_ymax as var_avg_ymax_mg,
oosummg.var_std_ymax as var_std_ymax_mg,
oosummg.var_avg_logm4p5_mg,
oosummg.var_std_logm4p5_mg,
oosummg.var_avg_i as var_avg_i_mg,
oosummg.var_std_i as var_std_i_mg,
/*--Zinc*/
/*--wt*/
oosumzn.wt_n_oocytes as wt_n_rec_zn,
oosumzn.wt_n_fit as wt_n_fit_zn,
oosumzn.wt_date_rec_count as wt_n_date_zn,
oosumzn.wt_avg_logec50 as wt_avg_logIC50_zn,
oosumzn.wt_std_logec50 as wt_std_logIC50_zn,
oosumzn.wt_avg_hillslope as wt_avg_hillslope_zn,
oosumzn.wt_std_hillslope as wt_std_hillslope_zn,
oosumzn.wt_avg_ymin as wt_avg_ymin_zn,
oosumzn.wt_std_ymin as wt_std_ymin_zn,
oosumzn.wt_avg_ymax as wt_avg_ymax_zn,
oosumzn.wt_std_ymax as wt_std_ymax_zn,
oosumzn.wt_avg_logm8_zn,
oosumzn.wt_std_logm8_zn,
oosumzn.wt_avg_logm6p5_zn,
oosumzn.wt_std_logm6p5_zn,
oosumzn.wt_avg_i as wt_avg_i_zn,
oosumzn.wt_std_i as wt_std_i_zn,
/*--var*/
oosumzn.var_n_oocytes as var_n_rec_zn,
oosumzn.var_n_fit as var_n_fit_zn,
oosumzn.var_date_rec_count as var_n_date_zn,
oosumzn.var_avg_logec50 as var_avg_logIC50_zn,
oosumzn.var_std_logec50 as var_std_logIC50_zn,
oosumzn.var_avg_hillslope as var_avg_hillslope_zn,
oosumzn.var_std_hillslope as var_std_hillslope_zn,
oosumzn.var_avg_ymin as var_avg_ymin_zn,
oosumzn.var_std_ymin as var_std_ymin_zn,
oosumzn.var_avg_ymax as var_avg_ymax_zn,
oosumzn.var_std_ymax as var_std_ymax_zn,
oosumzn.var_avg_logm8_zn,
oosumzn.var_std_logm8_zn,
oosumzn.var_avg_logm6p5_zn,
oosumzn.var_std_logm6p5_zn,
oosumzn.var_avg_i as var_avg_i_zn,
oosumzn.var_std_i as var_std_i_zn
from
human_variants_sumvar
left join
oosumglu
on
oosumglu.Variant = human_variants_sumvar.Variant
left join
oosumgly
on
oosumgly.Variant = human_variants_sumvar.Variant
left join
oosumph
on
oosumph.Variant = human_variants_sumvar.Variant
left join
oosummg
on
oosummg.Variant = human_variants_sumvar.Variant
left join
oosumzn
on
oosumzn.Variant = human_variants_sumvar.Variant
left join
gnomadsumvar
on
gnomadsumvar.Variant = human_variants_sumvar.Variant
left join
clinvarsumvar
on
clinvarsumvar.Variant = human_variants_sumvar.Variant
left join
lemkesumvar
on
lemkesumvar.Variant = human_variants_sumvar.Variant
left join
topmedsumvar
on
topmedsumvar.Variant = human_variants_sumvar.Variant;
CREATE VIEW `topmedsumvar` AS
SELECT
topmed.Variant AS Variant,
topmed_AlleleCount,
topmed_AlleleNum
from topmed
group by Variant
/* topmedsumvar(Variant,topmed_AlleleCount,topmed_AlleleNum) */;
CREATE VIEW `varoosumvar` AS 
select
   `varoocytes`.`Variant` AS `Variant`,
   `varoocytes`.`assay` AS `assay`,
   `varoocytes`.`glun1` AS `var_glun1`,
   `varoocytes`.`glun2` AS `var_glun2`,
   count(`varoocytes`.`file`) AS `var_n_oocytes`,
   count((`varoocytes`.`conv` = 1)) AS `var_n_fit`,
   count(distinct `varoocytes`.`date_rec`) AS `var_date_rec_count`,
   round(avg(`varoocytes`.`logec50`),2) AS `var_avg_logec50`,
   round(stdev(`varoocytes`.`logec50`),2) AS `var_std_logec50`,
   round(avg(`varoocytes`.`hillslope`),2) AS `var_avg_hillslope`,
   round(stdev(`varoocytes`.`hillslope`),2) AS `var_std_hillslope`,
   round(avg(`varoocytes`.`ymin`),2) AS `var_avg_ymin`,
   round(stdev(`varoocytes`.`ymin`),2) AS `var_std_ymin`,
   round(avg(`varoocytes`.`ymax`),2) AS `var_avg_ymax`,
   round(stdev(`varoocytes`.`ymax`),2) AS `var_std_ymax`,
   round(avg(`varoocytes`.`pH_per_inhib`),2) AS `var_avg_pH_per_inhib`,
   round(stdev(`varoocytes`.`pH_per_inhib`),2) AS `var_std_pH_per_inhib`,
   round(avg((
      case
         when
            (
               `varoocytes`.`assay` = 'mgDRC'
            )
         then
            `varoocytes`.`logm4p5`
         else
            NULL 
      end
   )),2) AS `var_avg_logm4p5_mg`, 
   round(stdev((
      case
         when
            (
               `varoocytes`.`assay` = 'mgDRC'
            )
         then
            `varoocytes`.`logm4p5`
         else
            NULL 
      end
   )),2) AS `var_std_logm4p5_mg`, 
   round(avg((
      case
         when
            (
               `varoocytes`.`assay` = 'znDRC'
            )
         then
            `varoocytes`.`logm8`
         else
            NULL 
      end
   )),2) AS `var_avg_logm8_zn`, 
   round(stdev((
      case
         when
            (
               `varoocytes`.`assay` = 'znDRC'
            )
         then
            `varoocytes`.`logm8`
         else
            NULL 
      end
   )),2) AS `var_std_logm8_zn`,
   round(avg((
      case
         when
            (
               `varoocytes`.`assay` = 'znDRC'
            )
         then
            `varoocytes`.`logm6p5`
         else
            NULL 
      end
   )),2) AS `var_avg_logm6p5_zn`, 
   round(stdev((
      case
         when
            (
               `varoocytes`.`assay` = 'znDRC'
            )
         then
            `varoocytes`.`logm6p5`
         else
            NULL 
      end
   )),2) AS `var_std_logm6p5_zn`,


   round(avg((
      case
         when
            (
               `varoocytes`.`assay` = 'gluDRC'
            )
         then
            `varoocytes`.`logm5p5`
         else
            NULL 
      end
   )),2) AS `var_avg_logm5p5_glu`, 
   round(stdev((
      case
         when
            (
               `varoocytes`.`assay` = 'gluDRC'
            )
         then
            `varoocytes`.`logm5p5`
         else
            NULL 
      end
   )),2) AS `var_std_logm5p5_glu`,
   round(avg((
      case
         when
            (
               `varoocytes`.`assay` = 'glyDRC'
            )
         then
            `varoocytes`.`logm6`
         else
            NULL 
      end
   )),2) AS `var_avg_logm6_gly`, 
   round(stdev((
      case
         when
            (
               `varoocytes`.`assay` = 'glyDRC'
            )
         then
            `varoocytes`.`logm6`
         else
            NULL 
      end
   )),2) AS `var_std_logm6_gly`,


    
round(avg(`varoocytes`.`i`),2) AS `var_avg_i`, 
round(stdev(`varoocytes`.`i`),2) AS `var_std_i` 
from
   `varoocytes` 
group by
   `varoocytes`.`Variant`, `varoocytes`.`assay`;
CREATE VIEW `wtoosumvar` AS 
select
   `wtoocytes`.`Variant` AS `Variant`,
   `wtoocytes`.`assay` AS `assay`,
   `wtoocytes`.`glun1` AS `wt_glun1`,
   `wtoocytes`.`glun2` AS `wt_glun2`,
   count(`wtoocytes`.`file`) AS `wt_n_oocytes`,
   count((`wtoocytes`.`conv` = 1)) AS `wt_n_fit`,
   count(distinct `wtoocytes`.`date_rec`) AS `wt_date_rec_count`,
   round(avg(`wtoocytes`.`logec50`),2) AS `wt_avg_logec50`,
   round(stdev(`wtoocytes`.`logec50`),2) AS `wt_std_logec50`,
   round(avg(`wtoocytes`.`hillslope`),2) AS `wt_avg_hillslope`,
   round(stdev(`wtoocytes`.`hillslope`),2) AS `wt_std_hillslope`,
   round(avg(`wtoocytes`.`ymin`),2) AS `wt_avg_ymin`,
   round(stdev(`wtoocytes`.`ymin`),2) AS `wt_std_ymin`,
   round(avg(`wtoocytes`.`ymax`),2) AS `wt_avg_ymax`,
   round(stdev(`wtoocytes`.`ymax`),2) AS `wt_std_ymax`,
   round(avg(`wtoocytes`.`pH_per_inhib`),2) AS `wt_avg_pH_per_inhib`,
   round(stdev(`wtoocytes`.`pH_per_inhib`),2) AS `wt_std_pH_per_inhib`,
   round(avg((
      case
         when
            (
               `wtoocytes`.`assay` = 'mgDRC'
            )
         then
            `wtoocytes`.`logm4p5`
         else
            NULL 
      end
   )),2) AS `wt_avg_logm4p5_mg`, 
   round(stdev((
      case
         when
            (
               `wtoocytes`.`assay` = 'mgDRC'
            )
         then
            `wtoocytes`.`logm4p5`
         else
            NULL 
      end
   )),2) AS `wt_std_logm4p5_mg`, 
   round(avg((
      case
         when
            (
               `wtoocytes`.`assay` = 'znDRC'
            )
         then
            `wtoocytes`.`logm8`
         else
            NULL 
      end
   )),2) AS `wt_avg_logm8_zn`, 
   round(stdev((
      case
         when
            (
               `wtoocytes`.`assay` = 'znDRC'
            )
         then
            `wtoocytes`.`logm8`
         else
            NULL 
      end
   )),2) AS `wt_std_logm8_zn`,
   round(avg((
      case
         when
            (
               `wtoocytes`.`assay` = 'znDRC'
            )
         then
            `wtoocytes`.`logm6p5`
         else
            NULL 
      end
   )),2) AS `wt_avg_logm6p5_zn`, 
   round(stdev((
      case
         when
            (
               `wtoocytes`.`assay` = 'znDRC'
            )
         then
            `wtoocytes`.`logm6p5`
         else
            NULL 
      end
   )),2) AS `wt_std_logm6p5_zn`,

   round(avg((
      case
         when
            (
               `wtoocytes`.`assay` = 'gluDRC'
            )
         then
            `wtoocytes`.`logm5p5`
         else
            NULL 
      end
   )),2) AS `wt_avg_logm5p5_glu`, 
   round(stdev((
      case
         when
            (
               `wtoocytes`.`assay` = 'gluDRC'
            )
         then
            `wtoocytes`.`logm5p5`
         else
            NULL 
      end
   )),2) AS `wt_std_logm5p5_glu`,
   round(avg((
      case
         when
            (
               `wtoocytes`.`assay` = 'glyDRC'
            )
         then
            `wtoocytes`.`logm6`
         else
            NULL 
      end
   )),2) AS `wt_avg_logm6_gly`, 
   round(stdev((
      case
         when
            (
               `wtoocytes`.`assay` = 'glyDRC'
            )
         then
            `wtoocytes`.`logm6`
         else
            NULL 
      end
   )),2) AS `wt_std_logm6_gly`,
round(avg(`wtoocytes`.`i`),2) AS `wt_avg_i`, 
round(stdev(`wtoocytes`.`i`),2) AS `wt_std_i` 
from
   `wtoocytes` 
group by
   `wtoocytes`.`Variant`, `wtoocytes`.`assay`;
CREATE VIEW `clinvarsumvar` AS 
SELECT
`clinvar_variant`.Variant,
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
`clinvar_variant`.`Variant`
/* clinvarsumvar(Variant,clinvar_DateCreated,clinvar_CountObs,clinvar_AlleleSource,clinvar_TestingMethod,clinvar_OrgName,clinvar_AffectedStatus,clinvar_Phenotype) */;
CREATE VIEW `gnomadsumvar` AS 
select 
gnomad_all.Variant,
SUM(gnomad_all.Allele_Count) AS gnomad_all_AlleleCount,
SUM(gnomad_all.Allele_Number) AS gnomad_all_AlleleNum,
SUM(gnomad_controls.Allele_Count) AS gnomad_controls_AlleleCount,
SUM(gnomad_controls.Allele_Number) AS gnomad_controls_AlleleNum,
SUM(gnomad_noncancer.Allele_Count) AS gnomad_noncancer_AlleleCount,
SUM(gnomad_noncancer.Allele_Number) AS gnomad_noncancer_AlleleNum,
SUM(gnomad_nonneuro.Allele_Count) AS gnomad_nonneuro_AlleleCount,
SUM(gnomad_nonneuro.Allele_Number) AS gnomad_nonneuro_AlleleNum,
SUM(gnomad_nontopmed.Allele_Count) AS gnomad_nontopmed_AlleleCount,
SUM(gnomad_nontopmed.Allele_Number) AS gnomad_nontopmed_AlleleNum
from gnomad_all
left join
gnomad_controls
on
gnomad_all.cDNA = gnomad_controls.cDNA and gnomad_all.Gene = gnomad_controls.Gene
left join
gnomad_noncancer
on
gnomad_all.cDNA = gnomad_noncancer.cDNA and gnomad_all.Gene = gnomad_noncancer.Gene
left join
gnomad_nonneuro
on
gnomad_all.cDNA = gnomad_nonneuro.cDNA and gnomad_all.Gene = gnomad_nonneuro.Gene
left join
gnomad_nontopmed
on
gnomad_all.cDNA = gnomad_nontopmed.cDNA and gnomad_all.Gene = gnomad_nontopmed.Gene
group by
gnomad_all.Variant
/* gnomadsumvar(Variant,gnomad_all_AlleleCount,gnomad_all_AlleleNum,gnomad_controls_AlleleCount,gnomad_controls_AlleleNum,gnomad_noncancer_AlleleCount,gnomad_noncancer_AlleleNum,gnomad_nonneuro_AlleleCount,gnomad_nonneuro_AlleleNum,gnomad_nontopmed_AlleleCount,gnomad_nontopmed_AlleleNum) */;
CREATE VIEW `lemkesumvar` AS 
SELECT
lemke.Variant AS Variant,
COUNT(lemke.Variant) AS lemke_Count,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_Zygosity,'',''), '|') AS lemke_Zygosity,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_AlleleSource,'',''), '|') AS lemke_AlleleSource,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_Sex,'',''), '|') AS lemke_Sex,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_SeqMethod || '-' || lemke.lemke_YearSeq,'',''), '|') AS lemke_Seq,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_FirstAuthor || '-' || lemke.lemke_YearPublished || ';PMID:' || lemke.lemke_PubMedID, '', ''), '/') AS lemke_PubMed,
lemke.lemke_DevDelay AS lemke_DevDelay,
lemke.lemke_Seizures AS lemke_Seizures
from lemke
group by lemke.Variant
/* lemkesumvar(Variant,lemke_Count,lemke_Zygosity,lemke_AlleleSource,lemke_Sex,lemke_Seq,lemke_PubMed,lemke_DevDelay,lemke_Seizures) */;
CREATE VIEW `lemkesumdna` AS 
SELECT
lemke.Variant AS Variant,
lemke.cDNA AS cDNA,
COUNT(lemke.Variant) AS lemke_Count,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_Zygosity,'',''), '|') AS lemke_Zygosity,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_AlleleSource,'',''), '|') AS lemke_AlleleSource,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_Sex,'',''), '|') AS lemke_Sex,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_SeqMethod || '-' || lemke.lemke_YearSeq,'',''), '|') AS lemke_Seq,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_FirstAuthor || '-' || lemke.lemke_YearPublished || ';PMID:' || lemke.lemke_PubMedID,'',''), '/') AS lemke_PubMed,
GROUP_CONCAT(replace(DISTINCT lemke.lemke_DevDelay || ";Seizures: " || lemke.lemke_Seizures,'',''), '|')AS lemke_Phenotype
from lemke
group by lemke.cDNA, lemke.Variant
/* lemkesumdna(Variant,cDNA,lemke_Count,lemke_Zygosity,lemke_AlleleSource,lemke_Sex,lemke_Seq,lemke_PubMed,lemke_Phenotype) */;
CREATE VIEW `human_variants_sumvar` AS 
select 
Gene,
aaNum,
GROUP_CONCAT(replace(DISTINCT cDNA,'',''), ';') as cDNA,
Protein,
Variant,
GROUP_CONCAT(replace(DISTINCT RefSeq,'',''), ';') as RefSeq,
GROUP_CONCAT(replace(DISTINCT datasource,'',''), ';') as datasource
from human_variants
group by
human_variants.Gene, human_variants.Variant
/* human_variants_sumvar(Gene,aaNum,cDNA,Protein,Variant,RefSeq,datasource) */;
CREATE VIEW `human_variants_sumdna` AS 
select 
Gene,
aaNum,
cDNA,
Protein,
Variant,
GROUP_CONCAT(replace(DISTINCT RefSeq,'',''), ';') as RefSeq,
GROUP_CONCAT(replace(DISTINCT datasource,'',''), ';') as datasource
from human_variants
group by
Gene, cDNA
/* human_variants_sumdna(Gene,aaNum,cDNA,Protein,Variant,RefSeq,datasource) */;
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
CREATE VIEW `clinvarsumdna` AS 
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
/* clinvarsumdna(Gene,Variant,cDNA,RefSeq,aaNum,clinvar_DateCreated,clinvar_CountObs,clinvar_AlleleSource,clinvar_TestingMethod,clinvar_OrgName,clinvar_AffectedStatus,clinvar_Phenotype) */;
CREATE TABLE IF NOT EXISTS "database"(
  Gene TEXT,
  aaNum INT,
  cDNA,
  Protein TEXT,
  Variant TEXT,
  RefSeq,
  gnomad_all_AlleleCount,
  gnomad_all_AlleleNum,
  gnomad_controls_AlleleCount,
  gnomad_controls_AlleleNum,
  gnomad_nonneuro_AlleleCount,
  gnomad_nonneuro_AlleleNum,
  gnomad_nontopmed_AlleleCount,
  gnomad_nontopmed_AlleleNum,
  clinvar_CountObs,
  clinvar_DateCreated TEXT,
  clinvar_AlleleSource,
  clinvar_TestingMethod,
  clinvar_OrgName,
  clinvar_AffectedStatus,
  clinvar_Phenotype,
  lemke_Count,
  lemke_Zygosity,
  lemke_AlleleSource,
  lemke_Sex,
  lemke_Seq,
  lemke_PubMed,
  lemke_DevDelay TEXT,
  lemke_Seizures TEXT,
  count_TOPMed INT,
  denom_TOPMed INT,
  wt_n_rec_glu,
  wt_n_fit_glu,
  wt_n_date_glu,
  wt_avg_logEC50_glu,
  wt_std_logEC50_glu,
  wt_avg_hillslope_glu,
  wt_std_hillslope_glu,
  wt_avg_ymin_glu,
  wt_std_ymin_glu,
  wt_avg_ymax_glu,
  wt_std_ymax_glu,
  wt_avg_logm5p5_glu,
  wt_std_logm5p5_glu,
  wt_avg_i_glu,
  wt_std_i_glu,
  var_n_rec_glu,
  var_n_fit_glu,
  var_n_date_glu,
  var_avg_logEC50_glu,
  var_std_logEC50_glu,
  var_avg_hillslope_glu,
  var_std_hillslope_glu,
  var_avg_ymin_glu,
  var_std_ymin_glu,
  var_avg_ymax_glu,
  var_std_ymax_glu,
  var_avg_logm5p5_glu,
  var_std_logm5p5_glu,
  var_avg_i_glu,
  var_std_i_glu,
  wt_n_rec_gly,
  wt_n_fit_gly,
  wt_n_frogs_gly,
  wt_avg_logEC50_gly,
  wt_std_logEC50_gly,
  wt_avg_hillslope_gly,
  wt_std_hillslope_gly,
  wt_avg_ymin_gly,
  wt_std_ymin_gly,
  wt_avg_ymax_gly,
  wt_std_ymax_gly,
  wt_avg_logm6_gly,
  wt_std_logm6_gly,
  wt_avg_i_gly,
  wt_std_i_gly,
  var_n_rec_gly,
  var_n_fit_gly,
  var_n_date_gly,
  var_avg_logEC50_gly,
  var_std_logEC50_gly,
  var_avg_hillslope_gly,
  var_std_hillslope_gly,
  var_avg_ymin_gly,
  var_std_ymin_gly,
  var_avg_ymax_gly,
  var_std_ymax_gly,
  var_avg_logm6_gly,
  var_std_logm6_gly,
  var_avg_i_gly,
  var_std_i_gly,
  wt_n_rec_ph,
  wt_n_date_ph,
  wt_avg_logm6p8_ph,
  wt_std_logm6p8_ph,
  wt_avg_i_ph,
  wt_std_i_ph,
  var_n_rec_ph,
  var_n_date_ph,
  var_avg_logm6p8_ph,
  var_std_logm6p8_ph,
  var_avg_i_ph,
  var_std_i_ph,
  wt_n_rec_mg,
  wt_n_fit_mg,
  wt_n_date_mg,
  wt_avg_logIC50_mg,
  wt_std_logIC50_mg,
  wt_avg_hillslope_mg,
  wt_std_hillslope_mg,
  wt_avg_ymin_mg,
  wt_std_ymin_mg,
  wt_avg_ymax_mg,
  wt_std_ymax_mg,
  wt_avg_logm4p5_mg,
  wt_std_logm4p5_mg,
  wt_avg_i_mg,
  wt_std_i_mg,
  var_n_rec_mg,
  var_n_fit_mg,
  var_n_date_mg,
  var_avg_logIC50_mg,
  var_std_logIC50_mg,
  var_avg_hillslope_mg,
  var_std_hillslope_mg,
  var_avg_ymin_mg,
  var_std_ymin_mg,
  var_avg_ymax_mg,
  var_std_ymax_mg,
  var_avg_logm4p5_mg,
  var_std_logm4p5_mg,
  var_avg_i_mg,
  var_std_i_mg,
  wt_n_rec_zn,
  wt_n_fit_zn,
  wt_n_date_zn,
  wt_avg_logIC50_zn,
  wt_std_logIC50_zn,
  wt_avg_hillslope_zn,
  wt_std_hillslope_zn,
  wt_avg_ymin_zn,
  wt_std_ymin_zn,
  wt_avg_ymax_zn,
  wt_std_ymax_zn,
  wt_avg_logm8_zn,
  wt_std_logm8_zn,
  wt_avg_logm6p5_zn,
  wt_std_logm6p5_zn,
  wt_avg_i_zn,
  wt_std_i_zn,
  var_n_rec_zn,
  var_n_fit_zn,
  var_n_date_zn,
  var_avg_logIC50_zn,
  var_std_logIC50_zn,
  var_avg_hillslope_zn,
  var_std_hillslope_zn,
  var_avg_ymin_zn,
  var_std_ymin_zn,
  var_avg_ymax_zn,
  var_std_ymax_zn,
  var_avg_logm8_zn,
  var_std_logm8_zn,
  var_avg_logm6p5_zn,
  var_std_logm6p5_zn,
  var_avg_i_zn,
  var_std_i_zn
);
