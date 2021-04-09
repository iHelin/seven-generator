<template>
    <el-menu-item :index="menu" @click="gotoRouteHandle(menu)">
        <i class="el-icon-s-data"></i>
        <span>{{ menu }}</span>
    </el-menu-item>
</template>

<script>
import SubMenu from './main-sidebar-sub-menu'

export default {
    name: 'sub-menu',
    props: {
        menu: {
            type: String,
            required: true
        },
        dynamicMenuRoutes: {
            type: Array,
            required: true
        }
    },
    components: {
        SubMenu
    },
    computed: {
        sidebarLayoutSkin: {
            get() {
                return this.$store.state.common.sidebarLayoutSkin
            }
        }
    },
    methods: {
        gotoRouteHandle(menu) {
            this.$router.push({
                name: 'home', query: {
                    schema: menu
                }
            });
        }
    }
}
</script>
