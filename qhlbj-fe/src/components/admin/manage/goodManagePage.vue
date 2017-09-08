<template>
<div class="good-wrapper">
  <div class="section catalog">
    <div class="list">
      <div class="list-header">
        <span>所有商品</span>
        <a href="javascript: void(0);" @click.stop="add">新建</a>
      </div>
      <v-pretty-scroll>
        <div class="list-content">
          <div class="list-content-item" @click.stop="view(item)" v-for="item in goods" :class="{active: item.id === current.id}">
            <a href="javascript: void(0);">{{ item.name }}</a>
            <div class="options">
              <Button type="error" size="small" @click.stop="del(item)">删除</Button>
            </div>
          </div>
        </div>
      </v-pretty-scroll>
      <div class="page">
        <Page :current="page.pageNum"
              :page-size="page.pageSize"
              :total="page.totalSize"
              @on-change="changePage"
              simple></Page>
      </div>
    </div>
  </div>
  <div class="section detail">
    <div class="list">
      <div class="list-header">
        <span>商品详情</span>
        <a href="javascript: void(0);" @click="update">更新</a>
      </div>
			<v-pretty-scroll>
				<div class="list-content" v-show="current.id">
					<Form ref="form" :model="current" :label-width="80">
						<Form-item prop="name" label="商品名称">
							<Input type="text" v-model="current.name" placeholder="请输入..."></Input>
						</Form-item>
						<Form-item prop="category" label="商品分类">
							<Cascader :data="categories" v-model="current.category"></Cascader>
						</Form-item>
						<Form-item label="图片">
							<Upload
								 ref="upload"
								 :show-upload-list="false"
								 :default-file-list="uploadList"
								 :on-success="onUploadSuccess"
								 :format="['jpg','jpeg','png']"
								 :max-size="2048"
								 :on-format-error="onUploadFormatError"
								 :on-exceeded-size="onUploadMaxSizeError"
								 :before-upload="onUploadBeforeAction"
								 type="drag"
								 :action="uploadAction"
								 style="display: inline-block;width:58px;">
							<div class="upload-list" style="width: 58px;height: 58px;line-height: 58px;">
								<img :src="imgUrl(current)" v-show="imgUrl(current) !== ''">
								<Icon type="ios-cloud-upload" size="28" color="black" v-show="imgUrl(current) === ''"></Icon>
							</div>
							</Upload>
						</Form-item>
						<Form-item prop="description" label="商品描述">
							<div id="editor"></div>
							<Input v-model="current.description" type="textarea" :autosize="{minRows: 4,maxRows: 6}" placeholder="请输入..."></Input>
						</Form-item>
					</Form>
				</div>
			</v-pretty-scroll>
    </div>
  </div>
  <Modal
      v-model="modal.create"
      title="添加商品"
      @on-ok="create">
        <Form ref="form" :model="model" :label-width="80">
          <Form-item prop="name" label="商品名称">
            <Input type="text" v-model="model.name" placeholder="请输入..."></Input>
          </Form-item>
          <Form-item prop="category" label="商品分类">
            <Cascader :data="categories" v-model="model.category"></Cascader>
          </Form-item>
          <Form-item label="图片">
            <Upload
              ref="upload"
              :show-upload-list="false"
              :default-file-list="uploadList"
              :on-success="onNewUploadSuccess"
              :format="['jpg','jpeg','png']"
              :max-size="2048"
              :on-format-error="onUploadFormatError"
              :on-exceeded-size="onUploadMaxSizeError"
              :before-upload="onUploadBeforeAction"
              type="drag"
							:action="uploadAction"
              style="display: inline-block;width:58px;">
              <div class="upload-list" style="width: 58px;height: 58px;line-height: 58px;">
                <img :src="imgUrl(model)" v-show="imgUrl(model) !== ''">
                <Icon type="ios-cloud-upload" size="28" color="black" v-show="imgUrl(model) === ''"></Icon>
              </div>
            </Upload>
          </Form-item>
          <Form-item prop="description" label="商品描述">
            <Input v-model="model.description" type="textarea" :autosize="{minRows: 4,maxRows: 6}" placeholder="请输入..."></Input>
          </Form-item>
        </Form>
  </Modal>
</div>
</template>

<script>
import CONST from '../../../../constant.js'
const E = require('wangeditor')
function _e(arg) {
  return arg === '' || arg === undefined || arg === null
}
export default {
  data: () => ({
    goods: [],
    uploadList: [],
		uploadAction: `${CONST.proxy}/api/image_contents`,
    current: {
      id: null,
      avatar: '',
      name: null,
      category: [],
      description: null
    },
    model: {
      avatar: null,
      name: null,
      category: [],
      description: null
    },
    page: {
      totalSize: 20,
      pageSize: 16,
      pageNum: 1,
    },
    categories: [],
    modal: {
      create: false
    }
  }),
  computed: {
  },
  methods: {
    imgUrl(ctx) {
      if (!_e(ctx.avatar)) {
        return CONST.proxy + ctx.avatar
      } else {
        return ''
      }
    },
    getGoods(defaultGood) {
      this.GET(this.API.goods, {
        categoryId: 'all',
        pageSize: this.page.pageSize,
        pageNum: this.page.pageNum,
      })
        .then(res => res.body).then(goods => {
          this.goods = goods
          if (defaultGood) {
            this.current = defaultGood
            this.view(defaultGood)
          } else {
            if (this.goods[0]) {
              this.goods[0] && this.view(this.goods[0])
              this.current = this.goods[0]
            }
          }
        })
    },
    getCategories() {
      this.GET(this.API.categories, {
        categoryId: 'all'
      }).then(res => res.body).then(cates => {
        let supCates = cates.filter(cate => !cate.supcategory_id)
        this.categories = supCates.map(supcate => {
          let subCates = cates.filter(cate => cate.supcategory_id === supcate.id)
          subCates = subCates.map(subcate => {
            return {
              label: subcate.name,
              value: subcate.id
            }
          })
          return {
            label: supcate.name,
            value: supcate.id,
            children: subCates
          }
        })
      })
    },
    changePage(pageNum) {
      this.page.pageNum = pageNum
      this.getGoods()
    },
    view(good) {
      this.GET(`${this.API.goods}/${good.id}`)
        .then(res => res.body).then(data => {
          let category = []
          if (data.category) {
            category = [data.supcategory.id, data.category.id]
          }
          this.current = {
            id: data.good.id,
            avatar: data.good.avatar,
            name: data.good.name,
            category: category,
            description: data.good.description
          }
        })
    },
    del(good) {
      this.DELETE(`${this.API.goods}/${good.id}`)
        .then(res => {
          if (this.current.id === good.id) {
            this.getGoods()
          } else {
            this.getGoods(this.current)
          }
          this.$Message.success('删除成功！')
        })
    },
    update() {
      this.PATCH(`${this.API.goods}/${this.current.id}`, {
        name: this.current.name,
        category_id: this.current.category ? this.current.category[1] : null,
        description: this.current.description,
        avatar: this.current.avatar
      })
        .then(res => {
          this.getGoods(this.current)
          this.$Message.success('更新成功')
        })
    },
    create() {
      this.POST(`${this.API.goods}`, {
        name: this.model.name,
        category_id: this.model.category ? this.model.category[1] : null,
        description: this.model.description,
        avatar: this.model.avatar
      })
        .then(res => {
          this.model = {
            name: '',
            category_id: [],
            description: '',
            avatar: '',
          }
          this.getGoods()
          this.$Message.success('添加成功')
        })
    },
    add() {
      this.modal.create = true
    },
    onUploadSuccess(res) {
      this.current.avatar = res.name.url
      this.$Notice.success({
        title: '图片上传成功！请点击【更新】以保存↘'
      })
    },
    onNewUploadSuccess(res) {
      this.model.avatar = res.name.url
    },
    onUploadFormatError() {

    },
    onUploadMaxSizeError() {

    },
    onUploadBeforeAction() {
      const check = this.uploadList.length < 1;
      if (!check) {
        this.$Notice.warning({
          title: '最多只能上传 1 张图片。'
        });
      }
      return check;
    },
    handleViewImg() {

    },
    handleDelImg() {

    }
  },
  created() {
    this.getGoods()
    this.getCategories()
  },
	mounted() {
	}
}
</script>

<style lang="scss" scoped>
.good-wrapper {
  flex: 1;
  display: flex;
  flex-wrap: wrap;
  height: calc(100vh - 148px);
  .section {
    padding: 4px;
    min-width: 32%;
    &.catalog {
      flex: 1;
      .list-content {
        display: flex;
        flex-wrap: wrap;
        .list-content-item {
          width: 50%;
          height: 48px;
        }
      }
    }
    &.detail {
      flex: 1;
      .list-content {
        padding: 38px 16px 0 0;
      }
    }
  }
}

.list {
  background: RGBA(70, 76, 91, .75);
  color: white;
  height: 100%;
  overflow: auto;
  position: relative;
  overflow: hidden;
  .list-header {
    position: absolute;
    z-index: 1;
    top: 0;
    left: 0;
    right: 0;
    padding: 4px;
    display: flex;
    background: RGBA(70, 76, 91, 1);
    justify-content: space-between;
    font-weight: bold;
    font-size: 15px;
  }
  .list-content {
    padding: 30px 0;
  }
  .list-content-item {
    padding: 4px 24px;
    justify-content: space-between;
    align-items: center;
    margin-top: 4px;
    font-size: 15px;
    cursor: pointer;
    a {
      text-decoration: none;
    }
    &.active {
      background: #313540;
      font-weight: bold;
    }
  }
}
.list {
  position: relative;
  .page {
    display: flex;
    justify-content: center;
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 4px;
    background: #464C5B;
  }
}

.upload-list {
  display: flex;
  justify-content: center;
  align-items: center;
}

.upload-list img {
  width: 100%;
  height: 100%;
}

</style>
<style>
    .ivu-form-item-label {
      color: white !important;
    }
    .ivu-modal-content {
      background: #464C5B !important;
    }
    .ivu-modal-header-inner {
      color: white !important;
    }
    .ivu-checkbox-wrapper span {
      color: white !important;
    }
</style>


