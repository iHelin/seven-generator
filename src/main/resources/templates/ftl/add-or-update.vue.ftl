<template>
    <el-dialog
            :title="!dataForm.id ? '新增' : '修改'"
            :close-on-click-modal="false"
            :visible.sync="visible">
        <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmit()"
                 label-width="80px">
            <#list columns as column>
                <#if column.columnName != pk.columnName>
                    <el-form-item label="${column.comments}" prop="${column.attrname}">
                        <el-input v-model="dataForm.${column.attrname}" placeholder="${column.comments}"></el-input>
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
                    <#list columns as column>
                    <#if column.columnName == pk.columnName>
                    ${column.attrname}: 0,
                    <#else>
                    ${column.attrname}: ''<#if column_index+1 != columns?size>, </#if>

                    </#if>
                    </#list>
                },
                dataRule: {
                    <#list columns as column>
                    <#if column.columnName != pk.columnName>
                    ${column.attrname}: [
                        {required: true, message: '${column.comments}不能为空', trigger: 'blur'}
                    ]<#if column_index+1 != columns?size>, </#if>

                    </#if>
                    </#list>
                }
            }
        },
        methods: {
            init(id) {
                this.dataForm.${pk.attrname} = id || 0
                this.visible = true
                this.$nextTick(() => {
                    this.$refs['dataForm'].resetFields()
                    if (this.dataForm.${pk.attrname}) {
                        this.$http({
                            url: `/${moduleName}/${pathName}/info/${r'${this.dataForm'}.${pk.attrname}}`,
                            method: 'get',
                            params: this.$http.adornParams()
                        }).then(({data}) => {
                            if (data && data.code === 0) {
                                <#list columns as column>
                                <#if column.columnName != pk.columnName>
                                this.dataForm.${column.attrname} = data.${classname}.${column.attrname}
                                </#if>
                                </#list>
                            }
                        })
                    }
                })
            },
            // 表单提交
            dataFormSubmit() {
                this.$refs['dataForm'].validate((valid) => {
                    if (valid) {
                        this.$http({
                            url: `/${moduleName}/${pathName}/${r'${!this.dataForm'}.${pk.attrname} ? 'save' : 'update'}`,
                            method: "post",
                            data: this.$http.adornData({
                                <#list columns as column>
                                <#if column.columnName != pk.columnName>
                                "${column.attrname}": this.dataForm.${column.attrname} || undefined,
                                <#else>
                                "${column.attrname}": this.dataForm.${column.attrname}<#if column_index+1 != columns?size>, </#if>
                                </#if>
                                </#list>
                            })
                        }).then(({data}) => {
                            if (data && data.code === 0) {
                                this.$message({
                                    message: '操作成功',
                                    type: 'success',
                                    duration: 1500,
                                    onClose: () => {
                                        this.visible = false
                                        this.$emit('refreshDataList')
                                    }
                                })
                            } else {
                                this.$message.error(data.msg)
                            }
                        })
                    }
                })
            }
        }
    }
</script>
