<template>
    <el-card :body-style="siteContentViewHeight">
        <keep-alive>
            <router-view/>
        </keep-alive>
    </el-card>
</template>

<script>

export default {
    inject: ['refresh'],
    data() {
        return {}
    },
    mounted() {
        this.$root.$on('next', (tabName) => {  //监听next事件，这里$root很重要，不懂去官网介绍
            this.removeTabHandle(tabName) //调用父路由中的方法
        });
    },
    computed: {
        siteContentViewHeight() {
            let height = this.documentClientHeight - 50 - 30 - 2;
            return {minHeight: height + 'px'}
        }
    },
    methods: {
        // tabs, 选中tab
        selectedTabHandle(tab) {
            tab = this.mainTabs.filter(item => item.name === tab.name)
            if (tab.length >= 1) {
                this.$router.push({name: tab[0].name, query: tab[0].query, params: tab[0].params})
            }
        },
        // tabs, 删除tab
        removeTabHandle(tabName) {
            this.mainTabs = this.mainTabs.filter(item => item.name !== tabName)
            if (this.mainTabs.length >= 1) {
                // 当前选中tab被删除
                if (tabName === this.mainTabsActiveName) {
                    const tab = this.mainTabs[this.mainTabs.length - 1];
                    this.$router.push({name: tab.name, query: tab.query, params: tab.params}, () => {
                        this.mainTabsActiveName = this.$route.name
                    });
                }
            } else {
                this.menuActiveName = '';
                this.$router.push({name: 'home'});
            }
        }
    }
}
</script>

