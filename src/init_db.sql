DROP DATABASE IF EXISTS `rongzheng`;
CREATE DATABASE IF NOT EXISTS `rongzheng` DEFAULT CHARACTER SET utf8;
USE `rongzheng`;
SOURCE data.sql;
SOURCE proc_rongzheng.sql;
SOURCE routines.sql;