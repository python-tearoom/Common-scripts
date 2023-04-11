--开启日志

SET GLOBAL log_output = 'TABLE'
SET GLOBAL general_log = 'ON'

--根据项目名称查询执行的sql

SELECT * FROM mysql.general_log
-- WHERE argument like '%UPDATE%'
-- where thread_id = '9569'
-- WHERE argument like '%5cfad43af77f459ba1f28c08721729b6%'
WHERE argument like CONCAT('%',(SELECT id FROM `t_project`
WHERE `Name` ='4update'),'%')
ORDER BY event_time DESC


--1.953s



SELECT DISTINCT(command_type) FROM mysql.general_log

SELECT * FROM mysql.general_log
WHERE argument like '%父子项目同模式%'
ORDER BY event_time DESC
-- WHERE command_type = 'Connect'


--查询进程命令
show processlist


--查询进程

SELECT * from information_schema.PROCESSLIST
WHERE HOST like '192.168.0.15%'

--KILL进程
KILL id

--查询正在锁的事务
select * from information_schema.innodb_locks


--查询等待锁的事务
select * from information_schema.innodb_locks_waits

--查询至哪个在执行的语句
show open tables where in_use >0