Rails.application.routes.draw do
  namespace :v1 do
    resources :messages, only: %i[index show create]
  end

  root to: "v1/messages#index"
end
