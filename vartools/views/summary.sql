DROP VIEW IF EXISTS `summary`;

CREATE 
 VIEW `summary` AS 
SELECT
all_variants_ext.gene as gene,
all_variants_ext.aa_orig as aa_orig,
all_variants_ext.aa_num as aa_num,
all_variants_ext.aa_var as aa_var,
all_variants_ext.sub_domain as sub_domain,
all_variants_ext.domain as domain,
all_variants_ext.variant as Variant,
/*--gnomADv2.1.1*/
gnomadv2.chromosome as gnomadv2_chromosome,
gnomadv2.position as gnomadv2_position,
gnomadv2.allele_ref as gnomadv2_allele_ref,
gnomadv2.allele_alt as gnomadv2_allele_alt,
gnomadv2.qual as gnomadv2_qual,
gnomadv2.filters as gnomadv2_filters,
gnomadv2.vartype as gnomadv2_vartype,
gnomadv2.gene as gnomadv2_gene,
gnomadv2.transcript_consequence as gnomadv2_transcript_consequence,
gnomadv2.protein_consequence as gnomadv2_protein_consequence,
gnomadv2.codon_num as gnomadv2_codon_num,
gnomadv2.ref_aa as gnomadv2_ref_aa,
gnomadv2.alt_aa as gnomadv2_alt_aa,
gnomadv2.FS as gnomadv2_FS,
gnomadv2.MQRankSum as gnomadv2_MQRankSum,
gnomadv2.InbreedingCoeff as gnomadv2_InbreedingCoeff,
gnomadv2.ReadPosRankSum as gnomadv2_ReadPosRankSum,
gnomadv2.VQSLOD as gnomadv2_VQSLOD,
gnomadv2.QD as gnomadv2_QD,
gnomadv2.DP as gnomadv2_DP,
gnomadv2.BaseQRankSum as gnomadv2_BaseQRankSum,
gnomadv2.MQ as gnomadv2_MQ,
gnomadv2.ClippingRankSum as gnomadv2_ClippingRankSum,
gnomadv2.rf_tp_probability as gnomadv2_rf_tp_probability,
gnomadv2.pab_max as gnomadv2_pab_max,
gnomadv2.AC as gnomadv2_AC,
gnomadv2.AN as gnomadv2_AN,
gnomadv2.non_neuro_AC as gnomadv2_non_neuro_AC,
gnomadv2.non_neuro_AN as gnomadv2_non_neuro_AN,
gnomadv2.non_cancer_AC as gnomadv2_non_cancer_AC,
gnomadv2.non_cancer_AN as gnomadv2_non_cancer_AN,
gnomadv2.non_topmed_AC as gnomadv2_non_topmed_AC,
gnomadv2.non_topmed_AN as gnomadv2_non_topmed_AN,
gnomadv2.controls_AC as gnomadv2_controls_AC,
gnomadv2.controls_AN as gnomadv2_controls_AN,
gnomadv2.source as gnomadv2_source,
/*--ClinVar*/
clinvarsumdna.Gene as clinvar_Gene,
clinvarsumdna.cDNA as clinvar_cDNA,
clinvarsumdna.aaNum as clinvar_aaNum,
clinvarsumdna.RefSeq as clinvar_RefSeq,
clinvarsumdna.clinvar_DateCreated,
clinvarsumdna.clinvar_CountObs,
clinvarsumdna.clinvar_AlleleSource,
clinvarsumdna.clinvar_TestingMethod,
clinvarsumdna.clinvar_OrgName,
clinvarsumdna.clinvar_OrgName,
clinvarsumdna.clinvar_AffectedStatus,
clinvarsumdna.clinvar_Phenotype,
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
FROM
all_variants_ext
LEFT JOIN
oosumglu
ON
oosumglu.Variant = all_variants_ext.variant
LEFT JOIN
oosumgly
ON
oosumgly.Variant = all_variants_ext.variant
LEFT JOIN
oosumph
ON
oosumph.Variant = all_variants_ext.variant
LEFT JOIN
oosummg
ON
oosummg.Variant = all_variants_ext.variant
LEFT JOIN
oosumzn
ON
oosumzn.Variant = all_variants_ext.variant
LEFT JOIN
gnomadv2
ON
gnomadv2.Variant = all_variants_ext.variant
LEFT JOIN
clinvarsumdna
ON
clinvarsumdna.Variant = all_variants_ext.variant
