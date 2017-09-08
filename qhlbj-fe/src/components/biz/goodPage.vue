<template>
    <div class="wrapper">
        <v-sync ref="fetchGood" :promise="promise">
          <div slot="loading">
            <v-spin size="30"></v-spin>
          </div>
          <div slot="done">
            <div class="good-wrapper">
                <div class="meta-info">
                  <div class="left">
                    <img :src="goodAvatar">
                  </div>
                  <div class="right">
                    <div class="name">{{ good.name }}</div>
                    <div class="category">
                      <Tag type="dot" color="blue">{{ good.category.supcategory.name }}</Tag>
                      -
                      <Tag type="border" color="blue">{{ good.category.name }}</Tag>
                    </div>
                  </div>
                </div>
                <div class="description">
                   {{ good.description }}
                </div>
            </div>
          </div>
          <div slot="fail"> fail </div>
        </v-sync>
    </div>
</template>
<script>
    import CONST from '../../../constant.js'
    export default {
      data: () => ({
        goodId: '',
        good: {
          avatar: '#',
          name: '',
          category: {
            name: '',
            supcategory: {
              name: '',
            }
          }
        },
        promise: null
      }),
      computed: {
        goodAvatar() {
          return CONST.proxy + this.good.avatar
        }
      },
      methods: {
        renderGood(good) {

        },
        getGoodInfo(id) {
          this.promise = this.GET(this.API.goods + `/${id}`)
          this.promise.then(res => res.body).then(data => {
            this.good = data.good
            this.good.category = data.category
            this.good.category.supcategory = data.supcategory
          })
        }
      },
      created() {
        this.goodId = this.$route.params.id
        this.getGoodInfo(this.goodId)
      }
    }
</script>
<style lang="scss" scoped>
.wrapper {
	margin: 0 20%;
	background: white;
	min-height: calc(100vh - 108px);
  padding-bottom: 48px;
  .good-wrapper {
    display: flex;
    flex-direction: column;
    .meta-info {
      display: flex;
      .left {
        padding: 20px;
        width: 278px;
        height: 170px;
        img {
          width: 100%;
          height: 100%;
        }
      }
      .right {
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        .name {
          font-size: 40px;
          font-weight: bold;
        }
      }
    }
    .description {
      padding: 20px;
      font-size: 20px;
    }
  }
}
</style>
