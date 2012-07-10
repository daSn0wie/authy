Lelylan::Application.routes.draw do

  namespace :oauth do
    get    "authorization" => "oauth_authorize#show", defaults: { format: "html" }
    post   "authorization" => "oauth_authorize#create", defaults: { format: "html" }
    delete "authorization" => "oauth_authorize#destroy", defaults: { format: "html" }
    delete "token/:id" => "oauth_token#destroy", defaults: { format: "json" }
    post   "token" => "oauth_token#create", defaults: { format: "json" }
  end

  resources :scopes

  resources :clients do
    put :block, on: :member
    put :unblock, on: :member
  end

  resources :accesses do
    put :block, on: :member
    put :unblock, on: :member
  end

end
