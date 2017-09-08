<template>
	<div class="index-wrapper" :class="{'shown-left': currentNav ===
				'index'}">
			<header class="header">
				<Menu mode="horizontal" theme="dark" :active-name="currentNav" @on-select="linkTo">
					<div class="layout-logo">
						<img :src="logo" alt="">
					</div>
					<div class="layout-nav">
						<Menu-item name="index">
							<Icon type="ios-navigate"></Icon>
							首页
						</Menu-item>
						<Menu-item name="info">
							<Icon type="ios-keypad"></Icon>
							公司简介
						</Menu-item>
						<Menu-item name="msgBoard">
							<Icon type="ios-analytics"></Icon>
							留言版
						</Menu-item>
						<Menu-item name="contact">
							<Icon type="ios-paper"></Icon>
							联系我
						</Menu-item>
					</div>
				</Menu>
			</header>
			<nav class="layout-content-navigator" >
				<v-pretty-scroll>
					<Menu theme="dark" class="left-nav"
								:active-name="activeName"
								width="auto"
							  @on-select="linkToCategory">
						<v-sync :promise="getCatePromise">
							<div slot="loading">
								<v-spin></v-spin>
							</div>
							<div slot="done">
								<template v-for="cate in categories">
									<Submenu :name="JSON.stringify(cate)">
										<template slot="title">{{ cate.name }}</template>
										<template v-for="subCate in cate.subCates">
											<Menu-item :name="JSON.stringify(subCate)">{{ subCate.name }}</Menu-item>
										</template>
									</Submenu>
								</template>
							</div>
							<div slot="fail">
								opps...
							</div>
						</v-sync>
					</Menu>
				</v-pretty-scroll>
			</nav>
			<div class="layout-main">
				<router-view></router-view>
			</div>
			<footer class="footer">
				<div class="layout-copy">
					2013-2017 &copy; QingHaiLiBaiJia
				</div>
			</footer>
	</div>
</template>
<script>
const logo = require('@/assets/logo.png')
export default {
	data: () => ({
		logo: logo,
		currentNav: '',
		topFixed: false,
		categories: [],
		selectedCate: null,
		getCatePromise: null,
		activeName: '',
	}),
	methods: {
		linkTo(navName) {
			this.$router.push({name: navName})
		},
		linkToCategory(category) {
			this.selectedCate = JSON.parse(category)
			this.$children[2].selectedCate = this.selectedCate
		},
		fixTop(status) {
			this.topFixed = status
		},
		getCategories(cb) {
			this.getCatePromise = this.GET(this.API.categories, {categoryId: 'all'})
			this.getCatePromise.then(res => res.body).then(categories => {
				let formateCates = this.R.filter(this.R.propEq('supcategory_id', null), categories)
				this.R.forEach(supCate => {
					let index = this.R.findIndex(this.R.propEq('id', supCate.id), formateCates)
					formateCates[index].subCates = this.R.filter(this.R.propEq('supcategory_id', supCate.id), categories)
				}, formateCates)
				this.categories = formateCates
			})
		}
	},
	watch: {
		$route(route) {
			const self = this
			this.currentNav = route.name
		}
	},
	created() {
		const self = this
		this.currentNav = this.$route.name
		this.getCategories()
	},
	mounted() {
		if (this.$route.name !== 'index') {
		}
	}
}
</script>
<style lang="scss" scoped>
.header {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	z-index: 200;
}
.layout-content-navigator {
	position: fixed;
	top: 60px;
	left: 0;
	bottom: 0;
	padding-bottom: 40px;
	display: none;
	z-index: 20;
	.index-wrapper.shown-left & {
		display: block;
	}
}
.layout-main {
	min-width: 950px;
	margin-top: 60px;
	.index-wrapper.shown-left & {
		margin-left: 200px;
	}
}
.footer {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
}
.index-wrapper {
  height: calc(100vh - 108px);
}
.layout-logo {
	width: 100px;
	height: 30px;
	/*background: #5b6270;*/
	border-radius: 3px;
	float: left;
	position: relative;
	top: 15px;
	left: 20px;
	img {
		width: 100%;
		height: 100%;
	}
}
.layout-main {
	margin-top: 60px;
}
.layout-assistant {
	height: 60px;
	background: #f5f7f9;
	border-bottom: 1px solid #d7dde4;
	display: flex;
	justify-content: center;
	align-items: center;
}
ul.left-nav {
	height: 100%;
	min-width: 160px;
	li:last-child {
		padding-bottom: 20px; // fix 左侧菜单最后一个显示不全
	}
}
.layout-nav {
	width: 420px;
	margin: 0 auto;
}
.reset-content {
	margin-top: 60px;
}

.layout-copy {
	/*border-top: 1px solid #d7dde4;*/
	text-align: center;
	padding: 10px 0 20px;
	color: #9ea7b4;
	background: #464C5B;
	z-index: 99;
}
</style>
<style>
.search-input input {
	border-top-right-radius: 0;
	border-bottom-right-radius: 0;
	border-right: none;
}

.search-button button {
	border-top-left-radius: 0 !important;
	border-bottom-left-radius: 0 !important;
	border-left: none !important;
}

#top-search {
	width: 300px;
}
</style>
<style lang="scss">
.layout-content-navigator {
	.vvue-pretty-scroll-inner-wrapper {
		padding-bottom: 0 !important;
	}
}
</style>
