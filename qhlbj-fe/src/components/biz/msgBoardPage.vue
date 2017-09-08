<template>
    <div class="wrapper">
        <div class="msg-editor">
            <Modal
                    v-model="inputUserNameModel"
                    title="怎么称呼您？"
                    @on-ok="setUserNameAndSubmitMsg"
                    @on-cancel="inputUserNameModel=false">
                <i-input v-model="username" placeholder="请输入..."></i-input>
            </Modal>
            <msg-editor ref="msgEditor" :config="msgEditorCfg" @on-confirm="submitMsg"></msg-editor>
        </div>
        <v-sync class="sync" :promise="promise">
            <div class="loading" slot="loading">
                <v-spin size="30"></v-spin>
            </div>
            <div slot="done">
                <div class="all-messages">
                    <div class="header">
                        {{ messagesNum }}条留言
                    </div>
                    <div class="body">
                        <section v-for="msg in allMsgs">
                            <msg-view class="message-view" :config="msg"></msg-view>
                        </section>
                    </div>
                </div>
            </div>
            <div slot="fail">
            </div>
        </v-sync>
    </div>
</template>
<script>
  import msgEditor from '@/components/biz/msgBoard/msgEditor'
  import msgView from '@/components/biz/msgBoard/msgView'

  const moment = require('moment')
  export default {
    components: {msgEditor, msgView},
    data: () => ({
      msgEditorCfg: {
        avatarSrc: 'static/img/logo.png'
      },
      allMsgs: [],
      promise: null,
      inputUserNameModel: false,
      username: '',
      msg: '',
    }),
    computed: {
      messagesNum() {
        return this.allMsgs.length
      }
    },
    methods: {
      setUserNameAndSubmitMsg() {
        localStorage.setItem('username', this.username)
        this.submitMsg(this.msg)
      },
      renderMessages(msgs) {
        this.allMsgs = msgs.map(item => ({
          name: item.name,
          date: moment(item.createdAt).format("YYYY.MM.DD HH:mm"),
          content: item.content
        }))
      },
      submitMsg(msg) {
        if (msg) {
          this.msg = msg
        } else {
          this.$Message.warning('您还没写下任何留言')
          return
        }
        let username = localStorage.getItem('username')
        if (!username) {
          this.inputUserNameModel = true
          return
        }
        this.POST(this.API.messages, {
          name: username,
          content: msg
        }).then(res => {
          // 201 => created
          if (res.status === 201) {
            this.getMessages()
            this.$refs.msgEditor.statusInit()
          }
        }).catch(ex => console.log(ex))
      },
      getMessages() {
        this.promise = this.GET(this.API.messages)
        this.promise.then(res => res.body)
          .then(msgs => this.renderMessages(msgs))
      }
    },
    created() {
      this.getMessages()
    }
  }
</script>
<style lang="scss" scoped>
    .wrapper {
        margin: 0 20%;
        padding: 15px;
        background: rgba(255, 255, 255, 1);
        // .message-editor {
        // }
        .all-messages {
            margin-top: 30px;
            .header {
                color: #464c5b;
                font-size: 18px;
                font-weight: bold;
                border-bottom: 1px solid #f0f0f0;
            }
            .body {
                margin-top: 15px;
                .message-view {
                    margin: 15px 0;
                    font-size: 16px;
                    padding-bottom: 15px;
                    border-bottom: 1px solid #f0f0f0;
                }
            }
        }
    }
</style>
<style>
    .sync {
        min-height: calc(100vh - 278px);
    }
    .loading {
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>
