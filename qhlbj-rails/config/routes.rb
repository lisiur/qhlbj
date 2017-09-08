Rails.application.routes.draw do
	scope '/api' do
		resources :categories
		resources :goods
		resources :messages
		resources :image_contents, only: [:create]
		resources :infos
		resources :contacts
		post 'admin/login', to: 'admin#login'
		post 'admin/logout', to: 'admin#logout'
		post 'admin/test', to: 'admin#test'
		post 'categories/addGoods', to: 'categories#add_goods'
	end
end
