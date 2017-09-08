// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App.vue'
import router from './router'

import iView from 'iview'
import 'iview/dist/styles/iview.css'

import vvue from 'vvue'

import libs from './libs'

Vue.use(iView)
Vue.use(vvue)
Vue.use(libs)
Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
