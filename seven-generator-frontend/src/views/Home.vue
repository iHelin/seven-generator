<template>
    <el-container style="height: 100vh;">
        <el-header style="text-align: right; font-size: 12px">
            <el-button type="primary" @click="handleGenerate">生成代码</el-button>
        </el-header>

        <el-main>
            <el-table
                stripe
                border
                ref="multipleTable"
                @selection-change="handleTableSelectChange"
                :data="tables">
                <el-table-column
                    type="selection"
                    width="55">
                </el-table-column>
                <el-table-column
                    label="序号"
                    align="center"
                    width="60"
                    type="index">
                </el-table-column>
                <el-table-column
                    prop="tableName"
                    label="表名">
                </el-table-column>
                <el-table-column
                    prop="tableComment"
                    label="表备注">
                </el-table-column>
                <el-table-column
                    width="100"
                    prop="engine"
                    label="Engine">
                </el-table-column>
                <el-table-column
                    prop="createTime"
                    label="创建时间">
                </el-table-column>
                <el-table-column
                    fixed="right"
                    header-align="center"
                    align="center"
                    width="150"
                    label="操作">
                    <template slot-scope="scope">
                        <el-button type="text"
                                   size="small"
                                   @click="generateSingle(scope.row)">
                            预览
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-main>
    </el-container>
</template>

<script>
export default {
    data() {
        return {
            tables: [],
            selectSchemaName: '',
            selectTableName: []
        }
    },
    watch: {
        $route(val) {
            this.handleSelect(val.query.schema)
        }
    },
    methods: {
        generateSingle(data) {
            this.$router.push({
                path: '/code-view',
                query: {
                    schemaName: this.selectSchemaName,
                    tableName: data.tableName
                }
            });
        },
        handleTableSelectChange(selection) {
            this.selectTableName = selection.map(item => item.tableName);
        },
        handleGenerate() {
            window.location.href = `/seven/code/${this.selectSchemaName}?tableNames=${this.selectTableName.join(',')}`;
        },
        handleSelect(schemaName) {
            this.selectSchemaName = schemaName;
            this.$http({
                url: `/seven/tables/${schemaName}`,
                method: 'get'
            }).then(({data}) => {
                this.tables = data.data;
            })
        }
    },
    mounted() {
    }
};
</script>
<style>
.el-header {
    background-color: #B3C0D1;
    color: #333;
    line-height: 60px;
}

.el-aside {
    color: #333;
}
</style>
