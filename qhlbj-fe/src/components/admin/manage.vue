<template>
    <div class="index-wrapper">
        <v-layout ref="layout">
            <header slot="header">
                <div class="layout-ceiling">
                    <div class="layout-ceiling-main">
                        <a href="#" @click="logout">退出</a>
                    </div>
                </div>
            </header>
            <nav slot="left" class="layout-content-navigator">
                <Menu theme="dark" class="left-nav" :active-name="currentNav" width="auto"
                      @on-select="linkToNav">
                    <Menu-item name="indexManage">首页管理</Menu-item>
                    <Menu-item name="goodManage">商品管理</Menu-item>
                    <Menu-item name="categoryManage">分类管理</Menu-item>
                    <Menu-item name="infoManage">公司简介</Menu-item>
                    <Menu-item name="contactManage">联系信息</Menu-item>
                    <!-- <Menu-item name="msgManage">留言管理</Menu-item> -->
                </Menu>
            </nav>
            <div class="layout-main">
                <router-view></router-view>
            </div>
            <template slot="footer">
                <div class="layout-copy">
                    2013-2017 &copy; QingHaiLiBaiJia
                </div>
            </template>
        </v-layout>
    </div>
</template>
<script>
  const logo = require('@/assets/logo.png')
  export default {
    data: () => ({
      logo: logo,
      currentNav: '',
    }),
    methods: {
      linkToNav(navName) {
        this.$router.push({ name: navName })
        this.currentNav = navName
      },
      logout() {
        this.POST(this.API.logout, {
          token: window.localStorage.token
        })
          .then(res => res.body)
          .then(data => {
            if (!data.login) {
              window.localStorage.token = null
              this.$router.push('/')
            } else {
              this.$Message.error('登出失败')
            }
          })
          .catch(err => {
            console.log(err)
          })
      },
    },
    created() {
      if (!window.localStorage.token) {
        this.$router.push('/login')
      }
      this.currentNav = this.$route.name

      if (this.currentNav === 'manage') {
        this.linkToNav('indexManage')
      }
    },
  }
</script>
<style lang="scss" scoped>
    .index-wrapper {
        height: 100vh;
    }
    .layout-logo {
        width: 100px;
        height: 30px;
        /*background: #5b6270;*/
        border-radius: 3px;
        float: left;
        position: relative;
        top: 15px;
        left: 20px;
        img {
            width: 100%;
            height: 100%;
        }
    }
    .layout-ceiling{
        box-sizing: border-box;
        display: flex;
        flex-direction: row-reverse;
        height: 60px;
        align-items: center;
        background: #464c5b;
        overflow: hidden;
    }
    .layout-ceiling-main{
        margin-right: 15px;
    }
    .layout-ceiling-main a{
        color: #9ba7b5;
    }
    .layout-assistant {
        height: 60px;
        background: #f5f7f9;
        border-bottom: 1px solid #d7dde4;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    ul.left-nav {
        height: 100%;
        li:last-child {
            padding-bottom: 20px; // fix 左侧菜单最后一个显示不全
        }
    }
    .layout-nav {
        width: 420px;
        margin: 0 auto;
    }
    .layout-main {
        display: flex;
        padding: 20px;
    }
    .layout-content-navigator {
        height: 100%;
    }
    .reset-content {
        margin-top: 60px;
    }

    .layout-copy {
        /*border-top: 1px solid #d7dde4;*/
        text-align: center;
        padding: 10px 0 20px;
        color: #9ea7b4;
        background: #464C5B;
        z-index: 99;
    }
</style>
<style lang="scss" scoped>
textarea {
}
</style>

<style scoped>
.ivu-form-item-label {
  color: white !important;
}
.ivu-input {
  background: transparent !important;
  color: white !important;
}
</style>


