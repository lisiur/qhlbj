<template>
    <div class="login-wrapper">
        <Card class="login-card">
            <p slot="title">登录</p>
            <Form :model="userModel">
                <Form-item prop="user">
                    <i-input type="text" v-model="userModel.name" placeholder="用户名" @on-enter="handleSubmit(userModel)">
                    <Icon type="ios-person-outline" slot="prepend"></Icon>
                    </i-input>
                </Form-item>
                <Form-item prop="password">
                    <i-input type="password" v-model="userModel.password" placeholder="密码" @on-enter="handleSubmit(userModel)">
                    <Icon type="ios-locked-outline" slot="prepend"></Icon>
                    </i-input>
                </Form-item>
                <Form-item>
                    <Button type="primary" @click="handleSubmit(userModel)">登录</Button>
                </Form-item>
            </Form>
        </Card>
    </div>
</template>
<script>
  const sha1 = require('sha1')
  const logo = require('@/assets/logo.png')
  export default {
    data: () => ({
      logo: logo,
      userModel: {
        name: '',
        password: '',
      }
    }),
    methods: {
      handleSubmit(userModel) {
        this.POST(this.API.login, {
          username: userModel.name,
          password: sha1(userModel.password)
        })
          .then(res => res.body)
          .then(data => {
            if (!data.login) {
              throw new Error('用户名或密码错误')
            } else {
              window.localStorage.token = data.token
              this.$router.push('/manage')
            }
          })
          .catch(err => {
            this.$Message.error('用户名或密码错误')
          })
      }
    },
  }
</script>
<style lang="scss" scoped>
    .login-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        .login-card {
          background: RGBA(70, 76, 91, .75);
          max-width: 500px;
          width: 50%;
        }
    }
</style>
<style>
.login-card .ivu-card-head p{
  color: white !important;
}
</style>


