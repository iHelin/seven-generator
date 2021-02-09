const path = require('path');

const resolve = dir => {
    return path.join(__dirname, dir)
};

module.exports = {
    outputDir:'../src/main/resources/static',
    chainWebpack: config => {
        config.resolve.alias
            .set('@', resolve('src')) // key,value自行定义，比如.set('@@', resolve('src/components'))
            .set('src', resolve('src'));
    },
    // 打包时不生成.map文件
    productionSourceMap: false,
    // 这里写你调用接口的基础路径，来解决跨域，如果设置了代理，那你本地开发环境的axios的baseUrl要写为 '' ，即空字符串
    devServer: {
        port: 9999,
        proxy: {
            'api': {
                logLevel: 'debug',
                target: 'http://localhost:8048/',
                changeOrigin: true,
                pathRewrite: {
                    '^/api': ''
                }
            }
        }
    }
};
