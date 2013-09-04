Srgt2::Application.routes.draw do
  root :to => 'home#index'

  get '/leases/search', to: 'leases#search_form'
  post '/leases/search', to: 'leases#search'
  resources :leases

  get '/tours/search', to: 'tours#search_form'
  post '/tours/search', to: 'tours#search'
  resources :tours

  get '/tenants/search', to: 'tenants#search_form'
  post '/tenants/search', to: 'tenants#search'
  resources :tenants

  get '/rooms/search', to: 'rooms#search_form'
  post '/rooms/search', to: 'rooms#search'
  resources :rooms

  get '/sales/search', to: 'sales#search_form'
  post '/sales/search', to: 'sales#search'
  resources :sales

  get '/properties/search', to: 'properties#search_form'
  post '/properties/search', to: 'properties#search'
  resources :properties

  post '/agents/login', to: 'agents#login'
  get '/agents/logout', to: 'agents#logout'
  get '/agents/search', to: 'agents#search_form'
  post '/agents/search', to: 'agents#search'
  resources :agents

  get '/clients/search', to: 'clients#search_form'
  post '/clients/search', to: 'clients#search'
  resources :clients

  get '/individuals/search', to: 'individuals#search_form'
  post '/individuals/search', to: 'individuals#search'
  resources :individuals

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
