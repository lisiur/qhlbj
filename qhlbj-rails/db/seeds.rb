categories = %w( 枸杞 冬虫夏草 )

Category.destroy_all
Good.destroy_all
Admin.destroy_all
Carousel.destroy_all

for cate in categories
	curCate = Category.find_or_create_by( { name: cate } )
	puts("菜单<#{curCate.name}> is created")
	for i in 1..3
		curSubCate = Category.find_or_create_by( { name: "#{cate}#{i}", supcategory_id: curCate.id } )
		puts("二级菜单<#{curSubCate.name}> is created")
		for j in 1..3
			good = Good.find_or_create_by( { name: "#{curSubCate.name}-good-#{j}", description: "#{curSubCate.name}-good-#{j}", category_id: curSubCate.id } )
			puts("商品<#{good.name}> is created")
		end
	end
end

password_digest = Digest::SHA1.hexdigest('790223lbjxhl')
Admin.create({name: 'qhlbj', password_digest: password_digest})
# Carousel.create
