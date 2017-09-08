import Vue from 'vue'
import Router from 'vue-router'
import Index from '@/components/Index'
import indexPage from '@/components/biz/indexPage'
import contactPage from '@/components/biz/contactPage'
import infoPage from '@/components/biz/infoPage'
import msgBoardPage from '@/components/biz/msgBoardPage'
import goodPage from '@/components/biz/goodPage'

import loginPage from '@/components/admin/login.vue'
import managePage from '@/components/admin/manage.vue'
import goodManagePage from '@/components/admin/manage/goodManagePage.vue'
import indexManagePage from '@/components/admin/manage/msgManagePage.vue'
import msgManagePage from '@/components/admin/manage/indexManagePage.vue'
import infoManagePage from '@/components/admin/manage/infoManagePage.vue'
import contactManagePage from '@/components/admin/manage/contactManagePage.vue'
import categoryManagePage from '@/components/admin/manage/categoryManagePage.vue'

import API from '../libs/api'
import { post as POST } from '../libs/utils'

Vue.use(Router)

let router = new Router({
  routes: [{
    path: '/',
    component: Index,
    children: [{
      name: 'index',
      path: '/',
      component: indexPage
    }, {
      name: 'contact',
      path: '/contact',
      component: contactPage
    }, {
      name: 'info',
      path: '/info',
      component: infoPage
    }, {
      name: 'msgBoard',
      path: '/msgBoard',
      component: msgBoardPage
    }, {
      name: 'good',
      path: '/good/:id',
      component: goodPage,
    }],
  }, {
    name: 'login',
    path: '/login',
    component: loginPage
  }, {
    name: 'manage',
    path: '/manage',
    component: managePage,
    beforeEnter: (to, from, next) => {
      POST(API.testLogin, {
        token: window.localStorage.token
      }).then( res => res.body)
        .then(data => {
          if (data.login) {
            next()
          } else {
            router.push('/login')
          }
        })
    },
    children: [{
      name: 'msgManage',
      path: '/msgManage',
      component: msgManagePage,
    }, {
      name: 'goodManage',
      path: '/goodManage',
      component: goodManagePage
    }, {
      name: 'contactManage',
      path: '/contactManage',
      component: contactManagePage
    }, {
      name: 'indexManage',
      path: '/indexManage',
      component: indexManagePage
    }, {
      name: 'infoManage',
      path: '/infoManage',
      component: infoManagePage
    }, {
      name: 'categoryManage',
      path: '/categoryManage',
      component: categoryManagePage
    }]
  }]
})

export default router
