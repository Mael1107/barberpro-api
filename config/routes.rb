Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/auth/register", to: "auth#register"
      post "/auth/login", to: "auth#login"
      get "/auth/me", to: "auth#me"
      get "/admin/test", to: "auth#admin_test"
      resources :services
    end
  end
end
