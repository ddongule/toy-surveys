Rails.application.routes.draw do

  root "home#index"

  get 'cock_recommend/index'

  get 'cock_recommend/warning'

  get 'cock_recommend/avoid'

  get 'cock_recommend/avoid_update'

  get 'cock_recommend/taste'

  get 'cock_recommend/taste_update'

  get 'cock_recommend/alcohol'

  get 'cock_recommend/alcohol_update'

  get 'cock_recommend/amount'
  
  get 'cock_recommend/amount_update'

  get 'cock_recommend/challenge'

  get 'cock_recommend/challenge_update'
  
  get 'cock_recommend/result'
  
  get 'cock_info/index'

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
