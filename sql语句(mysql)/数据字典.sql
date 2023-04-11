SELECT * FROM `t_filter` 
where name = 'buglist'


select TABLE_SCHEMA,TABLE_NAME,COLUMN_NAME,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH,CHARACTER_OCTET_LENGTH,COLUMN_TYPE,COLUMN_COMMENT
 from information_schema.columns where TABLE_SCHEMA='homingse_dev' #db_name代表数据库名
 
 select *
 from information_schema.columns where TABLE_SCHEMA='homingse_dev' #db_name代表数据库名