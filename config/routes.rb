Rails.application.routes.draw do
  root'pictures#index'
  resources :pictures

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

