SxbDataMissingApi::Application.routes.draw do
  scope module: :api, as: :api, subdomain: :api do
    scope module: :cts, as: :cts, subdomain: :cts do
      root to: redirect('/stops')
      scope module: :v1, format: :json do
        resources :stops, only: [:index, :show] do
          resources :arrivals
        end
      end
    end
  end
end
