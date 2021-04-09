import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

// 全局路由(无需嵌套上左右整体布局)
const globalRoutes = [
    {
        path: '/404',
        component: () => import('@/views/404'),
        name: '404',
        meta: {title: '404未找到'}
    }
]

const mainRoutes = {
    path: '/',
    component: () => import('@/views/main.vue'),
    name: 'main',
    redirect: {name: 'home'},
    meta: {title: '主入口整体布局'},
    children: [
        {
            path: '/home',
            component: () => import('@/views/Home'),
            name: 'home',
            meta: {title: '首页'}
        },
        {
            path: '/code-view',
            component: () => import('@/views/CodeView'),
            name: 'codeView',
            meta: {title: 'CodeView'}
        }
    ]
}

const router = new VueRouter({
    mode: 'hash',
    scrollBehavior: () => ({y: 0}),
    base: process.env.BASE_URL,
    isAddDynamicMenuRoutes: false,
    routes: globalRoutes.concat(mainRoutes)
});

export default router
