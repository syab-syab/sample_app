Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  # URL名 = '[コントローラー名]/[アクション名]'
  # httpメソッド 'URL'という感じ
  # rootでは'[コントローラー名]#[アクション名]'で指定可能
  root 'static_pages#home'
  # [url], to: [コントローラー名]#[アクション名]とすれば
  # 指定したurlにアクセスしたら指定したコントローラーのアクションを呼び出す
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'

  # ログイン関係のルーティング(コントローラーはsession)
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  # micropostsのルーティングはcreate(POST)とdestroy(DELETE)のみ
  resources :microposts,          only: [:create, :destroy]
end
