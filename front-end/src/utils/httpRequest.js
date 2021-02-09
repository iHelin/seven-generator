import axios from 'axios'

const http = axios.create({
    timeout: 1000 * 30,
    withCredentials: true,
    headers: {
        'Content-Type': 'application/json; charset=utf-8'
    }
})

/**
 * 请求拦截
 */
http.interceptors.request.use(config => {
    if (process.env.NODE_ENV === 'development') {
        config.url = '/api' + config.url
    }
    return config;
}, error => {
    return Promise.reject(error)
})


export default http
