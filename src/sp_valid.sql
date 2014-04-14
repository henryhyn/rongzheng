-- 第5步, 有效样本
DROP TABLE IF EXISTS RZ_Valid_Case;
CREATE TABLE `RZ_Valid_Case` (
  `类型` varchar(2) NOT NULL DEFAULT '',
  `职位内容` varchar(4) NOT NULL DEFAULT '',
  `类别` varchar(4) DEFAULT NULL,
  `计数` bigint(21) NOT NULL DEFAULT '0'
);
insert into RZ_Valid_Case
select '年薪','最高年薪',ELT(sign(年薪)+2,   '未披露','无效样本','有效样本'),count(股票代码)
    from RZ_Salary_7 group by sign(年薪);
insert into RZ_Valid_Case
select '年薪',职位内容,  ELT(sign(年薪)+2,   '未披露','无效样本','有效样本'),count(股票代码)
    from RZ_Salary_5 group by 职位内容, sign(年薪);
insert into RZ_Valid_Case
select '持股',职位内容,  ELT(sign(持股市值)+2,'未披露','无效样本','有效样本'),count(股票代码)
    from RZ_Stock_5 group by 职位内容, sign(持股市值);
    
DROP TABLE IF EXISTS RZ_Valid_Case_Salary;
CREATE TABLE `RZ_Valid_Case_Salary` (
  `类别` varchar(4) DEFAULT NULL,
  `最高年薪` int(11) DEFAULT '0',
  `董事长` int(11) DEFAULT '0',
  `总经理` int(11) DEFAULT '0',
  `副总经理` int(11) DEFAULT '0',
  `董秘` int(11) DEFAULT '0',
  `财务总监` int(11) DEFAULT '0',
  `独立董事` int(11) DEFAULT '0'
);
insert into RZ_Valid_Case_Salary (类别) values ("未披露"),("无效样本"),("有效样本");
update RZ_Valid_Case_Salary a, RZ_Valid_Case b set a.最高年薪=b.计数 where a.类别=b.类别 and 职位内容="最高年薪" and 类型="年薪";
update RZ_Valid_Case_Salary a, RZ_Valid_Case b set a.董事长  =b.计数 where a.类别=b.类别 and 职位内容="董事长"  and 类型="年薪";
update RZ_Valid_Case_Salary a, RZ_Valid_Case b set a.总经理  =b.计数 where a.类别=b.类别 and 职位内容="总经理"  and 类型="年薪";
update RZ_Valid_Case_Salary a, RZ_Valid_Case b set a.副总经理=b.计数 where a.类别=b.类别 and 职位内容="副总经理" and 类型="年薪";
update RZ_Valid_Case_Salary a, RZ_Valid_Case b set a.董秘   =b.计数 where a.类别=b.类别 and 职位内容="董秘"     and 类型="年薪";
update RZ_Valid_Case_Salary a, RZ_Valid_Case b set a.财务总监=b.计数 where a.类别=b.类别 and 职位内容="财务总监" and 类型="年薪";
update RZ_Valid_Case_Salary a, RZ_Valid_Case b set a.独立董事=b.计数 where a.类别=b.类别 and 职位内容="独立董事" and 类型="年薪";

DROP TABLE IF EXISTS RZ_Valid_Case_Stock;
CREATE TABLE `RZ_Valid_Case_Stock` (
  `类别` varchar(4) DEFAULT NULL,
  `董事长` int(11) DEFAULT '0',
  `总经理` int(11) DEFAULT '0',
  `副总经理` int(11) DEFAULT '0',
  `董秘` int(11) DEFAULT '0',
  `财务总监` int(11) DEFAULT '0'
);
insert into RZ_Valid_Case_Stock (类别) values ("未披露"),("无效样本"),("有效样本");
update RZ_Valid_Case_Stock a, RZ_Valid_Case b set a.董事长  =b.计数 where a.类别=b.类别 and 职位内容="董事长"  and 类型="持股";
update RZ_Valid_Case_Stock a, RZ_Valid_Case b set a.总经理  =b.计数 where a.类别=b.类别 and 职位内容="总经理"  and 类型="持股";
update RZ_Valid_Case_Stock a, RZ_Valid_Case b set a.副总经理=b.计数 where a.类别=b.类别 and 职位内容="副总经理" and 类型="持股";
update RZ_Valid_Case_Stock a, RZ_Valid_Case b set a.董秘   =b.计数 where a.类别=b.类别 and 职位内容="董秘"    and 类型="持股";
update RZ_Valid_Case_Stock a, RZ_Valid_Case b set a.财务总监=b.计数 where a.类别=b.类别 and 职位内容="财务总监" and 类型="持股";
