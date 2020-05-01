DROP TABLE IF EXISTS `RZ_Job_All_0000`;
CREATE TABLE `RZ_Job_All_0000` LIKE `RZ_Job_All`;

insert into `RZ_Job_All_0000`
select 职位, count(1) as 出现次数, 1000 as 职位秩序, '暂不考虑' as 职位内容
from (
    (select 职位 from RZ_Salary_0000)
    union all
    (select 职位 from RZ_Stock_0000)
) a group by 职位 order by 出现次数 desc;
UPDATE `RZ_Job_All_0000` a, `RZ_Job_All` b SET a.职位秩序=b.职位秩序, a.职位内容=b.职位内容 WHERE a.职位=b.职位;
REPLACE INTO `RZ_Job_All` SELECT * FROM `RZ_Job_All_0000`;
UPDATE RZ_Job_All a, RZ_Job b SET a.职位内容=b.职位内容 WHERE a.职位秩序=b.职位秩序;