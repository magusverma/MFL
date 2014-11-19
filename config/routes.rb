Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :users
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin'             => 'sessions#new', :as => :signin
  get '/signout'            => 'sessions#destroy', :as => :signout
  get '/auth/failure'       => 'sessions#failure'

  get 'dashboard'           => 'app#dashboard', :as => :dashboard
  get 'restaurants'         => 'app#restaurants', :as => :restaurants
  get 'foodlanes'           => 'app#foodlanes', :as => :foodlanes
  get 'trending'            => 'app#trending', :as => :trending
  get 'big_orders'          => 'app#big_orders', :as => :big_orders
  get 'preferences'         => 'app#preferences', :as => :preferences
  get 'foodlane_help'       => 'app#foodlane_help', :as => :foodlane_help
  
  post '/order/:rest_name/handle_order'       => 'app#handle_order', :as => :order_handler
  get '/order/:rest_name'                     => 'app#place_order', :as => :order_page
  # get 'restaurants'  
  # #get 'app/dashboard'

  # get 'app/restaurant_info' , :as => :restaurant_info

  # get 'app/place_order'

  # get 'app/confirm_order'

  # get 'app/see_order'

  # get 'app/see_foodlane', :as => :foodlane

  # get 'app/user_profile'

  # get 'public/rootpage'

  # get 'public/about', :as => :about

  # get 'public/contact'

  # get 'public/help'

  # get 'public/careers'

  # get 'public/joinus'


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
