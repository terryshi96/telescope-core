Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # RESTFul 默认生成路由
  EXCEPT_DEFAULT_ROUTES = [:index, :new, :create, :show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, except: EXCEPT_DEFAULT_ROUTES do
        collection do
          post :sign_in
        end
      end

    end
  end
end
