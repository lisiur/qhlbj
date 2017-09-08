<template>
    <div class="category-wrapper">
        <div class="category-level">
            <div class="list">
                <div class="list-header">
                    <span>一级分类</span>
                    <a href="javascript: void(0);" @click="newCategory">新建</a>
                </div>
                <div class="list-content">
                    <div class="list-content-item" @click="viewSubCates(item)" v-for="item in categoriesLV1" :class="{active: item.id === currentSupCate.id}">
                        <a href="javascript: void(0);">{{ item.name }}</a>
                        <div class="options">
                            <Button type="primary" size="small" @click.stop="editCate(item)">修改名称</Button>
                            <Button type="error" size="small" @click.stop="delCate(item)">删除</Button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="category-level">
            <div class="list">
                <div class="list-header">
                    <span>二级分类</span>
                    <a href="javascript: void(0);" @click="newSubCategory">新建</a>
                </div>
                <div class="list-content">
                    <div class="list-content-item" @click="viewGoods(item)" v-for="item in categoriesLV2" :class="{active: item === currentSubCate}">
                        <a href="javascript: void(0);">{{ item.name }}</a>
                        <div class="options">
                            <Button type="primary" size="small" @click.stop="editCate(item)">修改名称</Button>
                            <Button type="error" size="small" @click.stop="delCate(item)">删除</Button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="category-level">
            <div class="list">
                <div class="list-header">
                    <span>商品</span>
                    <a href="javascript: void(0);" @click="addGood">添加</a>
                </div>
                <div class="list-content">
                    <div class="list-content-item" v-for="item in goods">
                        <span>{{ item.name }}</span>
                        <div>
                            <!--<Button type="primary" size="small" @click="viewGoods(item)">编辑</Button>-->
                            <Button type="error" size="small" @click="delGood(item)">移出分类</Button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <Modal v-model="modals.modifyName"
               title="修改菜单名称"
               @on-ok="modifyName">
            <i-input v-model="modifyingCateName" placeholder="请输入..."></i-input>
        </Modal>

        <Modal v-model="modals.newCategory"
               title="新建一级菜单"
               @on-ok="createCategory">
            <i-input v-model="newCateName" placeholder="请输入..."></i-input>
        </Modal>

        <Modal v-model="modals.newSubCategory"
               title="新建二级菜单"
               @on-ok="createSubCategory">
            <i-input v-model="newSubCateName" placeholder="请输入..."></i-input>
        </Modal>

        <Modal v-model="modals.addGoods"
               title="选择商品"
               @on-ok="doAddGoods">
            <Checkbox-group v-model="addedGoods" v-show="allNoCateGoods.length > 0">
              <Checkbox class="checkitem" :label="good.id" v-for="good in allNoCateGoods" :key="good.id">
                  <span>{{ good.name }}</span>
              </Checkbox>
            </Checkbox-group>
            <div v-show="allNoCateGoods.length <= 0">所有的商品都已经有菜单了哦~</div>
        </Modal>

    </div>
</template>
<script>
  export default {
    data: () => ({
      categoriesLV1: [],
      categoriesLV2: [],
      goods: [],
      currentSupCate: null,
      currentSubCate: null,
      currentGood: null,

      modifyingCate: null,
      modifyingCateName: '',

      newCateName: '',
      newSubCateName: '',
      newCateSupId: null,
      newCateSubId: null,
      modals: {
        modifyName: false,
        newCategory: false,
        newSubCategory: false,
        addGoods: false,
      },
      addedGoods: [],
      allNoCateGoods: []
    }),
    methods: {
      viewSubCates(cate) {
        this.getSubCates(cate)
        this.currentSupCate = cate
      },
      viewGoods(cate) {
        this.getGoods(cate)
        this.currentSubCate = cate
      },
      getSupCates(defaultCate) {
        this.GET(this.API.categories, {
          categoryId: null
        }).then(res => res.body).then(cates => {
          this.categoriesLV1 = cates
          if (defaultCate) {
            this.viewSubCates(defaultCate)
          } else {
            this.categoriesLV1[0] && this.viewSubCates(this.categoriesLV1[0])
          }
        })
      },
      getSubCates(supCate) {
        this.GET(this.API.categories, {
          categoryId: supCate.id
        }).then(res => res.body).then(cates => {
          this.categoriesLV2 = cates
          if (this.categoriesLV2[0]) {
            this.viewGoods(this.categoriesLV2[0])
          } else {
            this.goods = []
          }
        })
      },
      getGoods(subCate) {
        this.GET(this.API.goods, {
          categoryId: subCate.id
        }).then(res => res.body).then(goods => {
          this.goods = goods
        })
      },
      getAllNoCateGoods() {
        this.GET(this.API.goods, {
          categoryId: null
        }).then(res => res.body).then(goods => {
          this.allNoCateGoods = goods
        })
      },
      delGood(good) {
        const self = this
        this.PATCH(`${this.API.goods}/${good.id}`, {
          name: good.name,
          description: good.description,
          avatar: good.avatar,
          category_id: null
        })
          .then(res => {
            self.getGoods(self.currentSubCate)
            this.$Message.success('移出成功！')
          })
      },
      delCate(cate) {
        const self = this
        this.DELETE(`${this.API.categories}/${cate.id}`)
          .then(res => {
            if (cate.supcategory_id) { // delete sub category
              self.getSupCates(this.currentSupCate)
            } else { // delete sup category
              self.getSupCates()
            }
            this.$Message.success('删除成功！')
          })
      },
      newCategory() {
        this.modals.newCategory = true
      },
      newSubCategory() {
        this.modals.newSubCategory = true
      },
      editCate(cate) {
        this.modifyingCateName = cate.name
        this.modifyingCate = cate
        this.modals.modifyName = true
      },
      modifyName() {
        const self = this
        this.modifyingCateName = this.modifyingCateName.trim()
        if (this.modifyingCateName === '') return

        this.PATCH(`${this.API.categories}/${this.modifyingCate.id}`, {
          name: this.modifyingCateName
        }).then(res => {
          self.modifyingCate.name = self.modifyingCateName

          self.modifyingCateName = ''
          this.$Message.success('修改成功！')
        })
      },
      createCategory() {
        this.newCateName = this.newCateName.trim()
        if (this.newCateName === '') return

        this.POST(`${this.API.categories}`, {
          name: this.newCateName
        }).then(res => {
          this.getSupCates()

          this.newCateName = ''
          this.$Message.success('添加成功！')
        })
      },
      createSubCategory() {
        this.newSubCateName = this.newSubCateName.trim()
        if (this.newSubCateName === '') return

        this.POST(`${this.API.categories}`, {
          name: this.newSubCateName,
          supcategory_id: this.currentSupCate.id
        }).then(res => {
          this.getSupCates(this.currentSupCate)

          this.newSubCateName = ''
          this.$Message.success('添加成功！')
        })
      },
      addGood() {
        this.getAllNoCateGoods()
        this.modals.addGoods = true
      },
      doAddGoods() {
        if (this.addedGoods.length === 0) return
        this.POST(this.API.addGoodsToCate, {
          id: this.currentSubCate.id,
          goodIds: this.addedGoods
        }).then(res => res.body).then(goods => {
          this.viewGoods(this.currentSubCate)
          this.addedGoods = []
          this.$Message.success('添加成功！')
        })
      }
    },
    created() {
      this.getSupCates()
    }
  }
</script>
<style lang="scss">
    .category-wrapper {
        flex: 1;
        display: flex;
        flex-wrap: wrap;
        height: calc(100vh - 148px);
        .category-level {
            flex: 1;
            padding: 4px;
            min-width: 32%;
        }
    }

    .list {
        background: RGBA(70, 76, 91, .75);
        color: white;
        height: 100%;
        overflow: auto;
        .list-header {
            padding: 4px;
            display: flex;
            background: RGBA(70, 76, 91, 1);
            justify-content: space-between;
            font-weight: bold;
            font-size: 15px;
        }
        .list-content-item {
            padding: 4px 24px;
            display: flex;
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
    .checkitem {
      width: 30%;
    }
</style>
