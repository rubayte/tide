Tide::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  match ':controller(/:action(/:id))(.:format)'
  root :to => 'app#index'
  match "index", :to => 'app#index'
  match "order", :to => 'app#order'
  match "messageUserLogin", :to => 'app#messageUserLogin'
  match "home", :to => 'users#home'
  match 'tideproject', :to => 'users#tideproject'
  match 'tideteam', :to => 'users#tideteam'
  match 'tideplans', :to => 'users#tideplans'
  match 'techreq', :to => 'users#techreq'
  match "updatePass", :to => 'users#updatePass'
  match "logout", :to => 'users#logout'
  match "adminDashboard", :to => 'admin#adminDashboard'
  match "admintideplans", :to => 'admin#admintideplans'
  match "admintideusers", :to => 'admin#admintideusers'
  match "admintideorders", :to => 'admin#admintideorders'
  match "admintidetickets", :to => 'admin#admintidetickets'
  match "admintidequestions", :to => 'admin#admintidequestions'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
