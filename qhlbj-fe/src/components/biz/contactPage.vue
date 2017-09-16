<template>
    <div class="wrapper">
        <v-sync class="sync" :promise="promise">
            <div class="loading" slot="loading">
                <v-spin size="30"></v-spin>
            </div>
            <div slot="done">
							<div class="content">
								<div class="items" v-if="!_e(contact.name)">
									<div class="label">联系人：</div>
									<div class="value">{{contact.name}}</div>
								</div>
								<div class="items" v-if="!_e(contact.mobile)">
									<div class="label">手机号：</div>
									<div class="value">{{contact.mobile}}</div>
								</div>
								<div class="items" v-if="!_e(contact.telphone)">
									<div class="label">固定电话：</div>
									<div class="value">{{contact.telphone}}</div>
								</div>
								<div class="items" v-if="!_e(contact.email)">
									<div class="label">邮箱：</div>
									<div class="value">{{contact.email}}</div>
								</div>
								<div class="items" v-if="!_e(contact.weixin)">
									<div class="label">微信：</div>
									<div class="value">{{contact.weixin}}</div>
								</div>
								<div class="items" v-if="!_e(contact.qq)">
									<div class="label">QQ：</div>
									<div class="value">{{contact.qq}}</div>
								</div>
								<div class="items" v-if="!_e(contact.weibo)">
									<div class="label">微博：</div>
									<div class="value">{{contact.weibo}}</div>
								</div>
								<div class="items" v-if="!_e(contact.address)">
									<div class="label">地址：</div>
									<div class="value">{{contact.address}}</div>
								</div>
							</div>
            </div>
            <div slot="fail">
            </div>
        </v-sync>
    </div>
</template>
<script>
import API from '../../libs/api.js'
import CONST from '../../../constant.js'
export default {
	data: () => ({
		promise: null,
		contact: {
			name: '',
			address: '',
			email: '',
			mobile: '',
			telphone: '',
			weixin: '',
			qq: '',
			weibo: '',
		},
	}),
	methods: {
		_e(ctx) {
			return ctx === '' || ctx === undefined || ctx === null
		}
	},
	created() {
		this.promise = this.GET(API.contact)
		this.promise.then(res => res.body)
			.then(res => {
				this.contact = {
					name: res.name,
					address: res.address,
					email: res.email,
					mobile: res.mobile,
					telphone: res.telphone,
					weixin: res.weixin,
					qq: res.qq,
					weibo: res.weibo,
				}
			})
	}
}
</script>
<style lang="scss" scoped>
.wrapper {
	margin: 0 20%;
	background: white;
	min-height: calc(100vh - 108px);
}
.wrapper .content {
	font-size: 20px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	min-height: calc(100vh - 108px);
	.items {
		width: 100%;
		height: 60px;
		display: flex;
		align-items: flex-start;
		justify-content: center;
		.label {

		}
	}
}
</style>
<style>
.layout-main {
	margin-bottom: 0;
}
</style>
								</div>
