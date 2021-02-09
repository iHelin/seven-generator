import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from 'src/views/Home.vue'
import CodeView from 'src/views/CodeView.vue'

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        redirect: '/home'
    },
    {
        path: '/home',
        name: 'Home',
        component: Home,
    },
    {
        path: '/code-view',
        name: 'CodeView',
        component: CodeView
    }
]

const router = new VueRouter({
    base: process.env.BASE_URL,
    routes
})

export default router
