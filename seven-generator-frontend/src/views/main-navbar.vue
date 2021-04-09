<template>
    <nav class="site-navbar" :class="'site-navbar--' + navbarLayoutType">
        <div class="site-navbar__header">
            <h1 class="site-navbar__brand" @click="$router.push({ name: 'home' })">
                <a class="site-navbar__brand-lg" href="javascript:">seven-generator</a>
                <a class="site-navbar__brand-mini" href="javascript:">seven</a>
            </h1>
        </div>
        <div class="site-navbar__body clearfix">
            <el-menu
                class="site-navbar__menu"
                mode="horizontal">
                <el-menu-item class="site-navbar__switch" index="0" @click="sidebarFold = !sidebarFold">
                    <i class="el-icon-s-fold"></i>
                </el-menu-item>
            </el-menu>
            <el-menu
                class="site-navbar__menu site-navbar__menu--right"
                mode="horizontal">
                <el-menu-item index="1" @click="$router.push({ name: 'theme' })">
                    <template slot="title">
                        <el-badge value="new">
                            <i class="el-icon-edit"></i>
                        </el-badge>
                    </template>
                </el-menu-item>
                <el-menu-item class="site-navbar__avatar" index="3">
                    <el-dropdown :show-timeout="0" placement="bottom">
                        <span class="el-dropdown-link">
                          <img src="~@/assets/avatar.png" :alt="username">
                            {{ username }}
                        </span>
                        <el-dropdown-menu slot="dropdown">
                            <el-dropdown-item @click.native="">修改密码</el-dropdown-item>
                            <el-dropdown-item @click.native="">退出</el-dropdown-item>
                        </el-dropdown-menu>
                    </el-dropdown>
                </el-menu-item>
            </el-menu>
        </div>
    </nav>
</template>

<script>
export default {
    data() {
        return {
            updatePasswordVisible: false
        }
    },
    components: {},
    computed: {
        navbarLayoutType: {
            get() {
                return this.$store.state.common.navbarLayoutType
            }
        },
        sidebarFold: {
            get() {
                return this.$store.state.common.sidebarFold
            },
            set(val) {
                this.$store.commit('common/updateSidebarFold', val)
            }
        },
        mainTabs: {
            get() {
                return this.$store.state.common.mainTabs
            },
            set(val) {
                this.$store.commit('common/updateMainTabs', val)
            }
        },
        username: {
            get() {
                return this.$store.state.user.name;
            }
        },
        avatarUrl: {
            get() {
                return this.$store.state.user.avatarUrl;
            }
        }
    },
    methods: {}
}
</script>
