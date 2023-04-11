
-- 查看过滤器信息  0否1是

SELECT IsDelete,IsPublic '是否公有',Inherit '是否继承',`Name`,PathName,CreatedOn FROM t_filter
WHERE `Name` = '父项目'


