Rails.application.routes.draw do

  root "home#index"

  get 'cock_recommend/index'

  get 'cock_recommend/result'
  
  get 'cock_info/index'

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
