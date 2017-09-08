import API from './api'
import { post, get, del, patch } from './utils'

import R from 'ramda'

export default {
  install(Vue, options) {
    Vue.prototype.API = API
    Vue.prototype.POST = post
    Vue.prototype.GET = get
    Vue.prototype.DELETE = del
    Vue.prototype.PATCH = patch
    Vue.prototype.R = R
  }
}