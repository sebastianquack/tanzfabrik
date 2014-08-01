Tanzfabrik::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
    
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  #get "/kalenderarchiv2" => redirect('http://archiv.tanzfabrik-berlin.de/kalenderarchiv2-kalender2%5Bshow%5D=archiv&kalender2%5Bvktg_code%5D%3D99&kalenderarchiv%5Byear%5D=2014&date=2587.php')

  get 'admin' => 'admin/pages#index'
  ActiveAdmin.routes(self)

  #get '*path' => redirect('http://archiv.tanzfabrik-berlin.de:path') # TODO: make this work - all unknown paths redirect to old site

  #get '/kurse.php' => redirect('/de/kursplan') # --> see application_controller

  scope "/:locale" do
    resources :events, :only => [:show, :index, :update]
    resources :people, :only => [:show, :update]
    resources :festivals, :only => [:show, :update]
    resources :pages, :only => [:show, :update], :path => ''
    resources :registrations, :only => [:create]
  end
  get '/:locale' => 'pages#show'

  #resources :pages, :only => [:update]
  #resources :events, :only => [:update]
  #resources :festivals, :only => [:update]

  # You can have the root of your site routed with "root"    
  root 'pages#show'



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
