Davidspattison::Application.routes.draw do
  
  namespace :c4 do
    resources :games do
      match 'move', :action => :move
    end
  end
  

  get "fyf/search"
  
  get 'facebook/oauth2/auth'
  get 'facebook/oauth2/index'
  match '/facebook/oauth2', :controller=> 'facebook/oauth2', :action=> :auth
  get 'facebook/oauth2/callback'

  namespace :tte do 
    resources :games do
      match 'move', :action => :move
      match 'restart', :action => :restart
    end
  end
  
  #this is used mostly for SEO, no links should use this directly, yet
  #using :host instead of :domain so ip-based hosts will work
  #https://github.com/rails/rails/issues/3800
  constraints :host => /.*tic-tac-toe\.us.*/ do
    resources :games, :path => '', :controller => 'tte/games'
  end
  
  

  resources :urlshorts
  match "urlshorts/redirect/:code" => 'urlshorts#redirect'
  match "u/:code" => 'urlshorts#redirect'

  namespace :spaste do resources :pastes end

  get "root/index"
  root :to => "root#index"
  get "tos" => "root#tos"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
