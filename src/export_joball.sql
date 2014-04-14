DROP TABLE IF EXISTS `RZ_Job_All_0000`;
CREATE TABLE `RZ_Job_All_0000` LIKE `RZ_Job_All`;

insert into `RZ_Job_All_0000`
select 职位, count(*) as 出现次数, 1000 as 职位秩序, "暂不考虑" as 职位内容
from (
    (select 职位 from RZ_Salary_0000)
    union all
    (select 职位 from RZ_Stock_0000)
) a group by 职位 order by 出现次数 desc;
REPLACE INTO `RZ_Job_All_0000` SELECT * FROM `RZ_Job_All`;

SELECT * INTO OUTFILE '/tmp/RZ_Job_All_0000.csv'
  CHARACTER SET UTF8
  FIELDS TERMINATED BY ',' ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  FROM `RZ_Job_All_0000`;