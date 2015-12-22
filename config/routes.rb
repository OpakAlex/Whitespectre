Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :group_events
    end
  end
end
