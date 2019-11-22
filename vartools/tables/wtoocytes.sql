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
