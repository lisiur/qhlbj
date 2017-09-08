<template>
    <div class="index-wrapper">
        <v-layout class="layout-content" body-clz="layout-body">
            <div class="layout-content-main">
                <div class="content-header">
                    <v-slider class="content-slider" width="650px" height="400px" auto
                              :source="sliderSource"></v-slider>
                </div>
                <div class="content-section">
									<h2>{{selectedCate ? selectedCate.name : "店长推荐" }}</h2>
                    <div class="goods">
                        <template v-for="good in goods">
                            <Card class="good-card" :padding="0">
                                <p slot="title">{{ good.title }}</p>
                                <p slot="extra">
                                    <Rate class="rate" allow-half disabled v-model="good.rate"></Rate>
                                </p>
                                <div class="content" @click="viewGood(good)">
                                    <img :src="good.image" alt="">
                                    <div class="cover">{{ good.introduction }}</div>
                                </div>
                            </Card>
                        </template>
                    </div>
                </div>
            </div>
        </v-layout>
    </div>
</template>

<script>
import images from '@/assets'
import API from '../../libs/api.js'
import CONST from '../../../constant.js'
export default {
	data: () => ({
		model: 4.5,
		sliderSource: images,
		goods: images.map(item => ({
			id: '1',
			title: '枸杞',
			rate: 4,
			image: item,
			introduction: '介绍，介绍，介绍'
		})),
		selectedCate: null,
	}),
	methods: {
		getGoods(cate) {
			this.GET(API.goods, {
				categoryId: cate.id
			})
			  .then(res => res.body)
				.then(res => {
					console.log(res)
					this.goods = res.map(item => ({
						id: item.id,
						title: item.name,
						rate: 5,
						image: item.avatar && `${CONST.proxy}${item.avatar}`,
						introduction: item.description,
					}))
				})
		},
		viewGood(good) {
      // this.$router.push({name: 'good', params: {id: good.id}})
      window.open(window.location.origin + '/#/good/' + good.id)
		},
	},
	created() {
	},
	watch: {
		selectedCate: function(cate) {
			this.getGoods(cate)
		}
	},
	created() {
	}
}
</script>
<style lang="scss" scoped>
.index-wrapper {
	margin-bottom: 60px;
}
.layout-content {
	width: 100%;
	.layout-content-main {
		padding: 10px;
		&.reset-content {
			margin-top: 60px;
		}
	}
}

.layout-content-navigator {
	height: 100%;
	width: 200px;
	background: #464C5B;
}

.layout-content-navigator .i-menu-ul {
	background: RGBA(70, 76, 91, .8);
	.ivu-menu-submenu-title {
		color: #fff;
	}
}


</style>
<style lang="scss" scoped>
.content-header {
	margin-top: 16px;
	display: flex;
	justify-content: center;
	align-items: center;
	.content-slider {
		border: 8px solid rgba(245, 247, 249, 1);
		border-radius: 10px;
	}
}

.content-header .curtain {
	width: 650px;
	height: 400px;
}

.content-header .curtain img {
	width: 100%;
	height: 100%;
}

.content-section {
	padding: 16px;
	h2 {
		margin-top: 15px;
		color: white;
		font-size: 20px;
	}
}

.goods {
	display: flex;
	flex-flow: row wrap;
	align-content: flex-start;
	justify-content: flex-start;
	padding-bottom: 60px;
	.good-card {
		display: inline-block;
		margin-top: 20px;
		margin-right: 16px;
		width: 280px;
		height: 230px;
		.rate {
			font-size: 12px;
		}
		.ivu-card-body {
			img {
				position: relative;
				width: 100%;
				height: 180px;
				left: 0;
				top: 0;
				transition: left .3s, top .3s, width .3s, height .3s;
			}
		}
		.content {
			height: 180px;
			position: relative;
			overflow: hidden;
			&:hover {
				img {
					left: -5%;
					top: -5%;
					width: 110%;
					height: 110%;
				}
				.cover {
					z-index: 1;
					opacity: 1;
				}
			}
			.cover {
				position: absolute;
				background-color: rgba(31, 45, 61, .7);
				cursor: pointer;
				color: white;
				left: 0;
				right: 0;
				top: 0;
				bottom: 0;
				transition: opacity .5s;
				opacity: 0;
				z-index: 0;
			}
		}
	}
}
</style>
