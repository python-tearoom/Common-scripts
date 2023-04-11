-- 项目代码库配置表 管理工具类型 ManagementType（0svn，1git ...）
SELECT SubmitUri 代码库地址,ManagementType 管理工具类型,Remark 备注,FilterContent 关联规则 
FROM t_project_repository_config
WHERE ProjectID  = (SELECT ID FROM t_project WHERE name like '%beginner%')

SELECT * FROM t_project_repository_config


-- 提交文件记录存储表

SELECT RecordType 提交类型,SubmitMessage 提交注释,CreatedByRealName 创建人,SubmitAuthor 提交人,SubmitVersion 提交版本 
FROM `t_project_repository_submit`
WHERE ProjectID  = (SELECT ID FROM t_project WHERE name like '%beginner%')
ORDER BY SubmitTime DESC


SELECT * FROM `t_project_repository_submit`


-- 提交文件记录明细表
SELECT * FROM t_project_repository_submit_item WHERE ProjectRepositoryID IN (SELECT ID FROM t_project WHERE name like '%beginner%')



SELECT * FROM t_project_repository_submit_item WHERE ProjectRepositoryID IN (
SELECT ID 
FROM `t_project_repository_submit`
WHERE ProjectID  = (SELECT ID FROM t_project WHERE name like '%beginner%')
ORDER BY SubmitTime DESC
)




SELECT * FROM t_project_repository_submit_item