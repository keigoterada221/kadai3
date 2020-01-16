Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   # ログインに成功したら自分の投稿一覧へ
root "books#index"

resources :books
resources :users
end
