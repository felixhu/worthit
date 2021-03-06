Worthit::Application.routes.draw do
  resources :regressions

  resources :listings

  get "pages/home"
  get "pages/result"
  get "pages/db"
  #get "pages/loaddb"
  
  get "/pages/home" => "pages#home"
  get "db" => "pages#db"
  get "/pages/dbadmin" => "pages#dbadmin"
  post "/pages/loaddb" => "pages#loaddb"
  get "/pages/resetdb" => "pages#resetdb"
  get "/pages/viewdb" => "pages#viewdb"
  get "/pages/help" => "pages#help"
  get "/pages/update" => "pages#update"
  get "/pages/reset" => "pages#reset"

  root to: 'pages#home'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'welcome#index'

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

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
