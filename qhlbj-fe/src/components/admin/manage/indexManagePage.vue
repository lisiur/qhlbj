<template>
	<div class="index-wrapper">
		<div class="section">
			<div class="list">
				<div class="list-header">
					<span>店长推荐</span>
					<a href="javascript: void(0);" @click.stop="update">更新</a>
				</div>
				<v-pretty-scroll>
					<div class="list-content">
                        <Checkbox-group v-model="addedGoods">
                            <Checkbox class="checkitem" :label="good.id" v-for="good in allGoods" :key="good.id">
                                <span>{{ good.name }}</span>
                            </Checkbox>
                        </Checkbox-group>
					</div>
				</v-pretty-scroll>
			</div>
		</div>
	</div>
</template>
<script>
export default {
    data: () => ({
        addedGoods: [],
        allGoods: []
    }),
    methods: {
        getSelectedGoods() {
            this.GET(this.API.carousels).then(res => res.body).then(goods => {
                this.addedGoods = goods.map(item => item.id)
            })
        },
        getGoods() {
            this.GET(this.API.goods, {
                categoryId: 'all'
            }).then(res => res.body).then(goods => {
                this.allGoods = goods
            })
        },
        update() {
            this.POST(this.API.updateCarousels, {
                goodIds: this.addedGoods
            }).then(res => res.body).then(goods => {
                this.getGoods()
                this.$Message.success('更新成功！')
            })
        }
    },
    created() {
        this.getSelectedGoods()
        this.getGoods()
    }

}
</script>
<style scoped lang='scss'>
.index-wrapper {
    height: calc(100vh - 148px);
    width: 100%;
    .section {
        padding: 4px;
        min-width: 68%;
        .list-content {
            padding: 16px;
        }
    }
}
</style>
