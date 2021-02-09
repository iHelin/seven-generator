<template>
    <el-container style="height: 600px; border: 1px solid #eee">
        <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
            <el-menu :default-openeds="['1']" @select="handleSelect">
                <el-submenu index="1">
                    <template slot="title"><i class="el-icon-message"></i>数据库</template>
                    <el-menu-item-group>
                        <el-menu-item v-for="schema in schemas" :index="schema">{{ schema }}</el-menu-item>
                    </el-menu-item-group>
                </el-submenu>
            </el-menu>
        </el-aside>

        <el-container>
            <el-header style="text-align: right; font-size: 12px">
                <!--                    <el-dropdown>-->
                <!--                        <i class="el-icon-setting" style="margin-right: 15px"></i>-->
                <!--                        <el-dropdown-menu slot="dropdown">-->
                <!--                            <el-dropdown-item>查看</el-dropdown-item>-->
                <!--                            <el-dropdown-item>新增</el-dropdown-item>-->
                <!--                            <el-dropdown-item>删除</el-dropdown-item>-->
                <!--                        </el-dropdown-menu>-->
                <!--                    </el-dropdown>-->
                <!--                    <span>王小虎</span>-->
                <el-button type="primary" @click="handleGenerate">生成代码</el-button>
            </el-header>

            <el-main>
                <el-table
                    stripe
                    height="600"
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
    </el-container>
</template>

<script>
export default {
    data() {
        return {
            schemas: [],
            tables: [],
            selectSchemaName: '',
            selectTableName: []
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
        this.$http({
            url: "/seven/schemas",
            method: 'get'
        }).then(({data}) => {
            this.schemas = data.data;
        })
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
