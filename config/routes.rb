Rails.application.routes.draw do
  # URL名 = '[コントローラー名]/[アクション名]'
  # httpメソッド 'URL'という感じ
  # rootでは'[コントローラー名]#[アクション名]'で指定可能
  root 'static_pages#home'
  get  'static_pages/home'
  get  'static_pages/help'
  get  'static_pages/about'

end
