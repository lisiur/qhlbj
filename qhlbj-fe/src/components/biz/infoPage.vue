<template>
    <div class="wrapper">
        <v-sync class="sync" :promise="promise">
            <div class="loading" slot="loading">
                <v-spin size="30"></v-spin>
            </div>
            <div slot="done">
							<div class="content">
								<!-- <div class="logo"> -->
								<!-- 	<img :src="info.logo" alt=""> -->
								<!-- </div> -->
								<div class="title"> <h2>{{info.name}}</h2> </div>
								<div class="intro"> <p>{{info.intro}}</p> </div>
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
		info: {
			name: '',
			logo: '',
			intro: '',
		},
		selectedCate: null,
	}),
	methods: {
	},
	created() {
		this.promise = this.GET(API.info)
		this.promise.then(res => res.body)
			.then(res => {
				this.info = {
					name: res.name,
					logo: res.logo && CONST.proxy + res.logo,
					intro: res.intro,
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
	.logo img {
		width: 200px;
		height: 100px;
	}
	.title {
		text-align: center;
		font-size: 32px;
		font-weight: bold;
		padding-top: 8px;
	}
	.intro {
		display: flex;
		font-size: 22px;
		text-align: left;
		p {
			overflow: hidden;
			padding: 32px 32px 60px;
			word-wrap: break-word;
			word-break: normal;
		}
	}
}
</style>
<style>
.layout-main {
	margin-bottom: 0;
}
</style>
