Tanzfabrik::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
    
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  #get "/kalenderarchiv2" => redirect('http://archiv.tanzfabrik-berlin.de/kalenderarchiv2-kalender2%5Bshow%5D=archiv&kalender2%5Bvktg_code%5D%3D99&kalenderarchiv%5Byear%5D=2014&date=2587.php')

  get 'admin' => 'admin/pages#index'
  ActiveAdmin.routes(self)

  #get '/kurse.php' => redirect('/de/kursplan') # --> see application_controller

  # special route for wrong slug 
  get '/en/tanzklassen-weekend-special-gaga', to: redirect('/en/tanzklassen-weekend-special')
  get '/de/tanzklassen-weekend-special-gaga', to: redirect('/de/tanzklassen-weekend-special')

  scope "/:locale", constraint: { locale: /en|de/ } do
    
    get 'festivals/tanznacht-forum', to: redirect('%{locale}/festivals/tanznacht-forum-2017')
    
    get 'programm/:year' => 'pages#show', :id => 'programm', :year => /\d{4}/ 
    get 'workshop_programm/:year' => 'pages#show', :id => 'workshop_programm', :year => '%{year}' 
    get 'performance_projekte/:year' => 'pages#show', :id => 'performance_projekte', :year => '%{year}' 

    resources :events, :only => [:show, :index, :update]
    get "events/:id/:time" => 'events#show'

    get "festivals/:festival_id/events/:id" => 'events#show'
    get "festivals/:festival_id/events/:id/:time" => 'events#show'

    resources :people, :only => [:show, :update]
    resources :festivals, :only => [:show, :update]
    resources :pages, :only => [:show, :update], :path => '' # route everything to pages controller
    resources :registrations, :only => [:create]
    resources :subscriptions, :only => [:create]
  end
  
  #resources :pages, :only => [:update]
  #resources :events, :only => [:update]
  #resources :festivals, :only => [:update]

  # You can have the root of your site routed with "root"    

  get '/de' => redirect('/')
  #get '/:locale' => "pages#show", :as => :local_root, locale: /[A-Za-z]{2}/

  get 'google0d69f052c5b126a8.html', to: proc { [200, {}, ['google-site-verification: google0d69f052c5b126a8.html']] }

#  get '*path' => "redirect#oldsite"
    
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
