SELECT * FROM t_pm_entity_list
WHERE no = '790'
ORDER BY no desc

-- 当前实体的实时信息
-- lf.listid,lf.FieldID
SELECT df.`Name` '属性名',lf.VALUE '属性值' FROM t_pm_entity_list_field lf,t_pm_entity_define_field df   
WHERE lf.ListID = (SELECT id from t_pm_entity_list where no = '790') and lf.FieldID = df.id


-- 实体历史记录(操作类型(0 新建 1 修改属性值，2 切换状态，3 上传附件 4 删除附件))
SELECT lh.OperType '操作类型',df.name '属性',lh.OldValue '原值',lh.NewValue '新值' FROM t_pm_entity_list_history lh,t_pm_entity_define_field df
where lh.ListID = (SELECT id from t_pm_entity_list where no = '790') and lh.FieldID = df.id 




SELECT * FROM  t_pm_entity_define_field