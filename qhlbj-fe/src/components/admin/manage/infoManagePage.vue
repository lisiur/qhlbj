<template>
	<div class="info-wrapper">
		<div class="section">
			<div class="list">
				<div class="list-header">
					<span>公司简介</span>
					<a href="javascript: void(0);" @click.stop="update">更新</a>
				</div>
				<v-pretty-scroll>
					<div class="list-content">
						<Form ref="form" :model="info" :label-width="80">
							<Form-item prop="name" label="公司名称">
								<Input type="text" v-model="info.name" placeholder="请输入..."></Input>
							</Form-item>
							<Form-item label="公司logo">
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
									<img :src="imgUrl(info)" v-show="imgUrl(info) !== ''">
									<Icon type="ios-cloud-upload" size="28" color="black" v-show="imgUrl(info) === ''"></Icon>
								</div>
								</Upload>
							</Form-item>
							<Form-item prop="intro" label="公司简介">
								<Input v-model="info.intro" type="textarea"
								:autosize="{minRows: 20,maxRows: 20}" placeholder="请输入..."></Input>
							</Form-item>
						</Form>
					</div>
				</v-pretty-scroll>
			</div>
		</div>
	</div>
</template>
<script>
import CONST from '../../../../constant.js'
function _e(arg) {
	return arg === '' || arg === undefined || arg === null
}
export default {
	data: () => ({
		info: {
			name: '',
			logo: '',
			intro: '',
			address: '',
		},
		uploadList: [],
		uploadAction: `${CONST.proxy}/api/image_contents`,
	}),
	methods: {
		imgUrl(ctx) {
      if (!_e(ctx.logo)) {
        return CONST.proxy + ctx.logo
      } else {
        return ''
      }
		},
		getInfo() {
      this.GET(`${this.API.info}`)
			  .then(res => res.body)
				.then(res => {
					this.info = {
						name: res.name,
						logo: res.logo,
						intro: res.intro,
					}
				})
		},
		update() {
      this.POST(`${this.API.info}`, {
        name: this.info.name,
				logo: this.info.logo,
				intro: this.info.intro,
      })
        .then(res => {
          this.$Message.success('更新成功')
        })
		},
    onUploadSuccess(res) {
      this.info.logo = res.name.url
      this.$Notice.success({
        title: '图片上传成功！请点击【更新】以保存↙'
      })
    },
    onUploadFormatError() {
      this.$Notice.warning({
        title: '只支持jpge, jpg, png格式的图片哦'
      })
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
		this.getInfo()
	}
}

</script>
<style lang="scss" scoped>
.info-wrapper {
  flex: 1;
  display: flex;
  flex-wrap: wrap;
	justify-content: center;
  height: calc(100vh - 148px);
  .section {
    padding: 4px;
    min-width: 68%;
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
    padding: 40px 0 0;
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
