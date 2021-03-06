DROP TABLE IF EXISTS `RZ_Job_All_0000`;
CREATE TABLE `RZ_Job_All_0000` LIKE `RZ_Job_All`;
LOAD DATA LOCAL INFILE 'RZ_Job_All_0000.csv' INTO TABLE `RZ_Job_All_0000`
  CHARACTER SET UTF8
  FIELDS TERMINATED BY '|' ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES;
REPLACE INTO `RZ_Job_All` SELECT * FROM `RZ_Job_All_0000`;
UPDATE RZ_Job_All a, RZ_Job b SET a.职位内容=b.职位内容 WHERE a.职位秩序=b.职位秩序;