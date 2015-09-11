Rails.application.routes.draw do

  get 'users/checkuser' => 'users#check_user'

  devise_for :users,  controllers: { registrations: "mydevisecontroller/registrations" }
  resources :likes
  resources :microposts
  resources :comments


  resources :users do
    collection do
      post 'signin'
    end
  end

  post 'logout' => 'users#signout'
  get 'users/:id/showposts' => 'users#show_user_posts', :as => :users_showposts

  get 'users/:id/microposts' => 'microposts#showposts_byuser_id'

  get 'users/:id/microposts/:micropost_id/comments' => 'comments#get_comments_for_micropost'
  root :to => 'microposts#index'
  #root 'users#index'
  #get 'login' => 'likes#index'

  
  #resource :comments
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
