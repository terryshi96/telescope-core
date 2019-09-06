Rails.application.routes.draw do
  use_doorkeeper
  # root to: "doorkeeper/token_info#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # RESTFul 默认生成路由
  EXCEPT_DEFAULT_ROUTES = [:index, :new, :create, :show, :edit, :update, :destroy]
  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post :sign_in
          post :sign_out
          get  :delete
          get  :get_users
        end
      end

      resources :domains, except: EXCEPT_DEFAULT_ROUTES do
        collection do
          post :create
          get  :get_domains
          get  :delete
          get  :refresh
        end
      end

      resources :receivers, except: EXCEPT_DEFAULT_ROUTES do
        collection do
          post :create
          post :update_receiver
          get  :delete
          get  :get_receivers
        end
      end

      resources :receiver_groups, except: EXCEPT_DEFAULT_ROUTES do
        collection do
          post :create
          get  :get_groups
          get  :delete
          post  :update_group
          post  :join_group
        end
      end
    end
  end
end
