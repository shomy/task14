Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root'pictures#index'
  resources :pictures

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
}

if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
# 省略
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

