<template>
	<div class="info-wrapper">
		<div class="section">
			<div class="list">
				<div class="list-header">
					<span>联系信息</span>
					<a href="javascript: void(0);" @click.stop="update">更新</a>
				</div>
				<v-pretty-scroll>
					<div class="list-content">
						<Form ref="form" :model="contact" :label-width="80">
							<Form-item prop="name" label="称呼">
								<Input type="text" v-model="contact.name" placeholder="请输入..."></Input>
							</Form-item>
							<Form-item prop="mobile" label="手机号">
								<Input type="text" v-model="contact.mobile" placeholder="请输入..."></Input>
							</Form-item>
							<Form-item prop="telphone" label="座机号">
								<Input type="text" v-model="contact.telphone" placeholder="请输入..."></Input>
							</Form-item>
							<Form-item prop="email" label="邮箱">
								<Input type="text" v-model="contact.email" placeholder="请输入..."></Input>
							</Form-item>
							<Form-item prop="weixin" label="微信号">
								<Input type="text" v-model="contact.weixin" placeholder="请输入..."></Input>
							</Form-item>
							<Form-item prop="weibo" label="微博号">
								<Input type="text" v-model="contact.weibo" placeholder="请输入..."></Input>
							</Form-item>
							<Form-item prop="qq" label="QQ号">
								<Input type="text" v-model="contact.qq" placeholder="请输入..."></Input>
							</Form-item>
							<Form-item prop="address" label="地址">
								<Input type="text" v-model="contact.address" placeholder="请输入..."></Input>
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
		contact: {
			name: '',
			mobile: '',
			telphone: '',
			email: '',
			weixin: '',
			weibo: '',
			qq: '',
			address: '',
		},
		uploadList: [],
		uploadAction: `${CONST.proxy}/api/image_contents`,
	}),
	methods: {
		getContact() {
      this.GET(`${this.API.contact}`)
			  .then(res => res.body)
				.then(res => {
					if (res) {
						this.contact = {
							name: res.name,
							mobile: res.mobile,
							telphone: res.telphone,
							email: res.email,
							weixin: res.weixin,
							weibo: res.weibo,
							qq: res.qq,
							address: res.address,
						}
					}
				})
		},
		update() {
      this.POST(`${this.API.contact}`, {
				name: this.contact.name,
				mobile: this.contact.mobile,
				telphone: this.contact.telphone,
				email: this.contact.email,
				weixin: this.contact.weixin,
				weibo: this.contact.weibo,
				qq: this.contact.qq,
				address: this.contact.address,
      })
        .then(res => {
          this.$Message.success('更新成功')
        })
		},
	},
	created() {
		this.getContact()
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
