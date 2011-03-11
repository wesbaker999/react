React::Application.routes.draw do
  resources :users
  resource  :user_session
  resources :invitations do
    member do
      post :accept
    end
  end
  resources :projects do
    resources :actors
    resources :memberships
    resources :features do
      member do
        put :developer_sign
        put :client_sign
        post :comment
      end
      collection do
        get :all
        get :unsigned
        get :signed
      end
    end
    resources :glossary_terms
    resources :invitations
    resources :estimates do
      member do
        put :developer_sign
        put :client_sign
      end
    end
    put 'memberships' => "memberships#index"
    member do
      put :generate_api_key
    end
  end
  namespace :api do
    resource :ci_reports
  end

  match 'signin' => "user_sessions#new"
  match 'signout' => "user_sessions#destroy"
  match 'signup' => "users#new"
  match 'dashboard' => "users#dashboard"

  get 'settings' => 'users#edit'
  put 'settings' => 'users#update'

  root :to => "user_sessions#new"
end
