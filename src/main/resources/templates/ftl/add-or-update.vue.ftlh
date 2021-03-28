<template>
    <el-dialog
            :title="dataForm.${tableEntity.pk.attrname} ? '修改' : '新增'"
            :close-on-click-modal="false"
            :visible.sync="visible">
        <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()"
                 label-width="100px">
            <#list tableEntity.columns as column>
                <#if column.columnName != tableEntity.pk.columnName>
                    <el-form-item label="${(column.columnComment?? && column.columnComment!='')?string(column.columnComment,column.attrname)}" prop="${column.attrname}">
                        <el-input v-model="dataForm.${column.attrname}" placeholder="${column.columnComment}"></el-input>
                    </el-form-item>
                </#if>
            </#list>
        </el-form>
        <span slot="footer" class="dialog-footer">
      <el-button @click="visible = false">取消</el-button>
      <el-button type="primary" @click="dataFormSubmit()">确定</el-button>
    </span>
    </el-dialog>
</template>

<script>
    export default {
        data() {
            return {
                visible: false,
                dataForm: {
                    <#list tableEntity.columns as column>
                    <#if column.columnName == tableEntity.pk.columnName>
                    ${column.attrname}: null,
                    <#else>
                    ${column.attrname}: ''<#if column_index != tableEntity.columns?size-1>, </#if>
                    </#if>
                    </#list>
                },
                dataRule: {
                    <#list tableEntity.columns as column>
                    <#if column.columnName != tableEntity.pk.columnName>
                    ${column.attrname}: [
                        {required: true, message: '${column.columnComment}不能为空', trigger: 'blur'}
                    ]<#if column_index != tableEntity.columns?size-1>, </#if>
                    </#if>
                    </#list>
                }
            }
        },
        methods: {
            init(id) {
                this.dataForm.${tableEntity.pk.attrname} = id;
                this.visible = true;
                this.$nextTick(() => {
                    this.$refs['dataForm'].resetFields();
                    if (this.dataForm.${tableEntity.pk.attrname}) {
                        this.$http({
                            url: '/${moduleName}/${tableEntity.classname?lower_case}/info/' + this.dataForm.${tableEntity.pk.attrname},
                            method: 'get',
                            params: {}
                        }).then(({data}) => {
                            if (data && data.code === 0) {
                                <#list tableEntity.columns as column>
                                <#if column.columnName != tableEntity.pk.columnName>
                                this.dataForm.${column.attrname} = data.data.${column.attrname};
                                </#if>
                                </#list>
                            } else {
                                this.$message.error(data.msg);
                            }
                        });
                    }
                });
            },
            // 表单提交
            dataFormSubmit() {
                this.$refs['dataForm'].validate((valid) => {
                    if (valid) {
                        this.$http({
                            url: '/${moduleName}/${tableEntity.classname?lower_case}/' + (this.dataForm.${tableEntity.pk.attrname} ? 'update' : 'save'),
                            method: this.dataForm.${tableEntity.pk.attrname} ? 'put' : 'post',
                            data: {
                                <#list tableEntity.columns as column>
                                <#if column.columnName == tableEntity.pk.columnName>
                                ${column.attrname}: this.dataForm.${column.attrname},
                                <#else>
                                ${column.attrname}: this.dataForm.${column.attrname}<#if column_index != tableEntity.columns?size-1>,</#if>
                                </#if>
                                </#list>
                            }
                        }).then(({data}) => {
                            if (data && data.code === 0) {
                                this.$message({
                                    message: '操作成功',
                                    type: 'success',
                                    duration: 1500,
                                    onClose: () => {
                                        this.visible = false;
                                        this.$emit('refreshDataList');
                                    }
                                });
                            } else {
                                this.$message.error(data.msg);
                            }
                        });
                    }
                })
            }
        }
    }
</script>
