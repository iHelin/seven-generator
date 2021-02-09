<template>
    <el-row :gutter="20">
        <el-col :span="6">
            <el-table
                :data="tableData"
                border
                stripe
                highlight-current-row
                @current-change="handleCurrentChange"
                style="width: 100%">
                <el-table-column
                    align="center"
                    prop="name"
                    label="名称">
                </el-table-column>
            </el-table>
        </el-col>
        <el-col :span="18">
            <el-header style="font-size: 20px">
                {{ currentFileName }}
            </el-header>
            <codemirror :value="codeText" :options="cmOption"></codemirror>
        </el-col>
    </el-row>
</template>
<script>
import {codemirror} from 'vue-codemirror'
import 'codemirror/lib/codemirror.css'

require("codemirror/mode/clike/clike.js");

export default {
    name: "CodeView",
    components: {
        codemirror
    },
    data() {
        return {
            schemaName: '',
            tableName: '',
            currentFileName: '',
            codeText: '',
            tableData: [{
                name: 'Entity.java'
            }, {
                name: 'Dao.java'
            }, {
                name: 'Dao.xml'
            }, {
                name: 'Service.java'
            }, {
                name: 'ServiceImpl.java'
            }, {
                name: 'Controller.java'
            }, {
                name: 'index.vue'
            }, {
                name: 'add-or-update.vue'
            }],
            cmOption: {
                lineNumbers: true,
                mode: "text/x-java"
            }
        }
    },
    methods: {
        handleCurrentChange(val) {
            this.currentFileName = val.name;
            this.$http({
                url: "/seven/code",
                method: 'get',
                params: {
                    schemaName: this.schemaName,
                    tableName: this.tableName,
                    fileName: this.currentFileName
                }
            }).then(({data}) => {
                this.codeText = data.data;
            })
        }
    },
    mounted() {
        this.schemaName = this.$route.query.schemaName;
        this.tableName = this.$route.query.tableName;
    }
}
</script>

<style>
.CodeMirror {
    height: auto;
    border: 1px solid #eee;
}
</style>
