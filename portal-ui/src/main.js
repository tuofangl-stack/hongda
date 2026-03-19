import Vue from 'vue'
import App from './App.vue'
import router from './router'
import './assets/css/style.css'
import {getRequest} from "@/api/api";

// Element UI
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
Vue.use(ElementUI, { size: 'medium' })

// Admin 样式
import './assets/css/admin.css'

Vue.prototype.getRequest = getRequest;

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
