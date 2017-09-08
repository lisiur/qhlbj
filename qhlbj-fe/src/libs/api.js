import CONST from '../../constant.js'
const proxy = `${CONST.proxy}/api`
export default {
  goods: `${proxy}/goods`,
  messages: `${proxy}/messages`,
  info: `${proxy}/infos`,
  contact: `${proxy}/contacts`,
  login: `${proxy}/admin/login`,
  logout: `${proxy}/admin/logout`,
  testLogin: `${proxy}/admin/test`,
  categories: `${proxy}/categories`,
  addGoodsToCate: `${proxy}/categories/addGoods`,
}
