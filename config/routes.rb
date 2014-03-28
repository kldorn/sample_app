SampleApp::Application.routes.draw do  
 
  # Listing 5.35
  get "users/new"
  
  # These book examples are supposed to be exchangable
  # Neither works in isolation.
  #root  'static_pages#home'  
  #match '/', to: 'static_pages#home', via: 'get'
  
  # This works. But you need to use http://localhost:3000/ 
  # instead of http://localhost:3000/sample_apps to display the page now.
  #root :to => 'static_pages#home'

  # This combination works with either. But you need both statements.
  # http://localhost:3000/ or http://localhost:3000/static_pages/home
  root  'static_pages#home'
  get "static_pages/home"

  match '/signup',  to: 'users#new',            via: 'get'

  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
end

  #Listing 5.24. & 5.26 Routes for static pages. 
  # Replace get with match statements
  #get "static_pages/home"
  #get "static_pages/help"
  #get "static_pages/about"
  #get "static_pages/contact"


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