<template>
    <div>
        <el-form :inline="true" @keyup.enter.native="getDataList()">
            <el-form-item>
                <el-input v-model="key" placeholder="参数名" clearable></el-input>
            </el-form-item>
            <el-form-item>
                <el-button v-if="isAuth('${moduleName}:${tableEntity.classname?lower_case}:list')"
                           @click="getDataList()">查询</el-button>
                <el-button v-if="isAuth('${moduleName}:${tableEntity.classname?lower_case}:save')"
                           type="primary"
                           @click="addOrUpdateHandle()">
                    新增
                </el-button>
                <el-button v-if="isAuth('${moduleName}:${tableEntity.classname?lower_case}:delete')"
                           type="danger"
                           @click="deleteHandle()"
                           :disabled="dataListSelections.length <= 0">
                    批量删除
                </el-button>
            </el-form-item>
        </el-form>
        <el-table
                :data="dataList"
                border
                v-loading="dataListLoading"
                @selection-change="selectionChangeHandle"
                style="width: 100%;">
            <el-table-column
                    type="selection"
                    header-align="center"
                    align="center"
                    width="50">
            </el-table-column>
            <#list tableEntity.columns as column>
                <el-table-column
                        prop="${column.attrname}"
                        header-align="center"
                        align="center"
                        label="${column.columnComment}">
                </el-table-column>
            </#list>
            <el-table-column
                    fixed="right"
                    header-align="center"
                    align="center"
                    width="150"
                    label="操作">
                <template slot-scope="scope">
                    <el-button v-if="isAuth('${moduleName}:${tableEntity.classname?lower_case}:update')"
                               type="text"
                               size="small"
                               @click="addOrUpdateHandle(scope.row.${tableEntity.pk.attrname})">
                        修改
                    </el-button>
                    <el-button v-if="isAuth('${moduleName}:${tableEntity.classname?lower_case}:delete')"
                               type="text" size="small" @click="deleteHandle(scope.row.${tableEntity.pk.attrname})">
                        删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-pagination
                @size-change="sizeChangeHandle"
                @current-change="currentChangeHandle"
                :current-page="pageIndex"
                :page-sizes="[10, 20, 50, 100]"
                :page-size="pageSize"
                :total="totalPage"
                layout="total, sizes, prev, pager, next, jumper">
        </el-pagination>
        <!-- 弹窗, 新增 / 修改 -->
        <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
    </div>
</template>

<script>
    import AddOrUpdate from './add-or-update.vue'

    export default {
        data() {
            return {
                key: '',
                dataList: [],
                pageIndex: 1,
                pageSize: 10,
                totalPage: 0,
                dataListLoading: false,
                dataListSelections: [],
                addOrUpdateVisible: false
            }
        },
        components: {
            AddOrUpdate
        },
        activated() {
            this.getDataList();
        },
        methods: {
            // 获取数据列表
            getDataList() {
                if(!this.isAuth('${moduleName}:${tableEntity.classname?lower_case}:list')){
                    return;
                }
                this.dataListLoading = true;
                this.$http({
                    url: '/${moduleName}/${tableEntity.classname?lower_case}/list',
                    method: 'get',
                    params: {
                        'page': this.pageIndex,
                        'limit': this.pageSize,
                        'key': this.key
                    }
                }).then(({data}) => {
                    if (data && data.code === 0) {
                        this.dataList = data.data.records;
                        this.totalPage = data.data.total;
                    } else {
                        this.$message.error(data.msg);
                        this.dataList = [];
                        this.totalPage = 0;
                    }
                    this.dataListLoading = false;
                });
            },
            // 每页数
            sizeChangeHandle(val) {
                this.pageSize = val;
                this.pageIndex = 1;
                this.getDataList();
            },
            // 当前页
            currentChangeHandle(val) {
                this.pageIndex = val;
                this.getDataList();
            },
            // 多选
            selectionChangeHandle(val) {
                this.dataListSelections = val;
            },
            // 新增 / 修改
            addOrUpdateHandle(id) {
                this.addOrUpdateVisible = true;
                this.$nextTick(() => {
                    this.$refs.addOrUpdate.init(id);
                });
            },
            // 删除
            deleteHandle(id) {
                let ids = id ? [id] : this.dataListSelections.map(item => item.${tableEntity.pk.attrname});
                this.$confirm("确定删除？", '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    this.$http({
                        url: '/${moduleName}/${tableEntity.classname?lower_case}/delete',
                        method: 'delete',
                        data: ids
                    }).then(({data}) => {
                        if (data && data.code === 0) {
                            this.$message({
                                message: '操作成功',
                                type: 'success',
                                duration: 1500,
                                onClose: () => {
                                    this.getDataList();
                                }
                            });
                        } else {
                            this.$message.error(data.msg);
                        }
                    });
                });
            }
        }
    }
</script>
