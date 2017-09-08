<template>
    <div class="editor-wrapper">
        <div class="avatar">
            <img src="../../../assets/logo.png" alt="">
        </div>
        <div class="content">
            <i-input v-model="content" :rows="4" type="textarea" placeholder="请输入..."
                     @on-focus="showOptions=true"></i-input>
            <div class="options" v-show="showOptions">
                <Button type="text" size="large" @click="cancel">取消</Button>
                <Button type="success" size="large" @click="confirm">留言</Button>
            </div>
        </div>
    </div>
</template>
<script>
    export default {
      data: () => ({
        content: '',
        showOptions: false,
      }),
      methods: {
        confirm() {
          this.$emit('on-confirm', this.content)
        },
        cancel() {
          this.content = ''
          this.showOptions = false
        },
        statusInit() {
          this.content = ''
          this.showOptions = false
        },
      },
      props: {
        config: {
          type: Object,
          default: () => ({
            avatarSrc: '',
          }),
        }
      }
    }
</script>
<style lang="scss" scoped>
    .editor-wrapper {
        display: flex;
        justify-content: space-around;
        .avatar {
            width: 38px;
            height: 38px;
            margin-right: 10px;
            img {
                width: 100%;
                height: 100%;
            }
        }
        .content {
            flex: 1;
            textarea.ivu-input {
              color: #000000 !important;
            }
            .options {
                margin-top: 8px;
                display: flex;
                justify-content: flex-end;
                button {
                    margin-left: 8px;
                }
            }
        }
    }
</style>
