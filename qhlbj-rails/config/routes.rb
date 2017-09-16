Rails.application.routes.draw do
  resources :recommends
	scope '/api' do
		resources :categories
		resources :goods
		resources :messages
		resources :image_contents, only: [:create]
		resources :infos
		resources :contacts
		resources :carousels
		post 'admin/login', to: 'admin#login'
		post 'admin/logout', to: 'admin#logout'
		post 'admin/test', to: 'admin#test'
		post 'categories/addGoods', to: 'categories#add_goods'
		post 'carousels/updateGoods', to: 'carousels#update_goods'
	end
end
