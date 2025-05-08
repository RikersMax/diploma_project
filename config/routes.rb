Rails.application.routes.draw do
  root "guests#index"

  resources(:users, only: %i[index new show edit create update destroy])
  resources(:accounting_object, except: %i[create])
  resources(:session, only: %i[new create destroy])

  post('accounting_object_psot', to: 'accounting_object#create', as: 'accounting_object_post')

  #resources(:test_a)
end
