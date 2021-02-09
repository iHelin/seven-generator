import Vue from 'vue'
import App from './App.vue'
import router from './router'

import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import httpRequest from '@/utils/httpRequest' // api: https://github.com/axios/axios

Vue.use(ElementUI);

Vue.config.productionTip = false
Vue.prototype.$http = httpRequest // ajax请求方法


new Vue({
    router,
    render: h => h(App)
}).$mount('#app')
