FanaticV2::Application.routes.draw do
  root "public#index"
  get "public/index"
  get "posts/tags" => "posts#tags", :as => :tags
  get "posts/sort_created" => "posts#sort_created"
  get 'tags/:tag', to: 'posts#index', as: :tag
  get 'users/:id/posts' => 'users#posts', :as => :user_posts
  match "menu/headlines" => 'menu#headlines', via: [:get, :post]
  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  match "onboarding" => 'onboarding#index', via: [:get, :post]
  get "sessions/authentications"
  match "/signout" => "sessions#destroy", :as => :signout, via: [:get, :post]

  match "users/dashboardtest" => "users#dashboardtest", via: [:get]

  resources :friendships
  resources :users
  resources :friendships
  resources :teams
  resources :posts do
    collection do
      get :list
    end
    member { post :vote }
  resources :comments
end
    
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
