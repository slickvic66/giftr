Giftr::Application.routes.draw do

  root to: "static_pages#home"

  devise_for :users, :path => "accounts", 
                     :path_names => { :sign_in => "login", 
                                      :sign_out => "logout", 
                                      :sign_up => "register" }

  resources :users do
    resource :profile
  end

  resources :memberships, :only => [:create]
  resources :exchanges do
      post :make_matches, :on => :member
      resources :gifts, :only => [:index], :on => :member do 
        post :add_gift, :on => :member
      end
  end

  resources :gift_ideas, :only => [:index, :create]

  put "/accept/:id", to: "invitations#accept_invite", :as => :accept 
  put "/deny/:id", to: "invitations#deny_invite", :as => :deny

  get "/contact", to: "static_pages#contact"
  get "/faq", to: "static_pages#faq"
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
