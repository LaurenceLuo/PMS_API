Rails.application.routes.draw do
    resources :rooms do
        resources :guests
    end
end
