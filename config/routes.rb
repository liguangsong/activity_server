ActivityServer::Application.routes.draw do
  resources :users
  resources :sessions
  resources :admins
  root 'sessions#new'
  post 'admins_add_new_user'=>'admins#add_new_user'
  get 'admins_add_new_user_page'=>'admins#add_new_user_page'
  get 'admins_quit'=>'admins#quit'
  get 'admins_repair_user_password_page'=>'admins#repair_user_password_page'
  post 'admins_repair_user_password'=>'admins#repair_user_password'
  get 'users_forget_password_page'=>'users#forget_password_page'
  post 'users_confirm_user_name'=>'users#confirm_user_name'
  get 'users_compare_question_page'=>'users#compare_question_page'
  post 'users_compare_question'=>'users#compare_question'
  get 'users_change_password_page'=>'users#change_password_page'
  post 'users_change_password'=>'users#change_password'
  post '/sessions/user_authentication'=>'sessions#user_authentication'
  post '/sessions/update'=>'sessions#update'
  get 'users_bid_list_page'=>"users#bid_list_page"
  get 'users_sign_up_page'=>"users#sign_up_page"
  get 'users_bidding_page'=>"users#bidding_page"
  #get 'users'=>'users#new'
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
