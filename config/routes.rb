Rails.application.routes.draw do
 
  root('guests#index')
  get('/about', to: 'guests#about')

  resources(:users, only: %i[index new show edit create update])
  resources(:accounting_object, except: %i[create])
  resources(:categories, except: %i[new show])
  resources(:operations, except: %i[show])

  resource(:session, only: %i[new create destroy])
  #resource(:password_reset, only: %i[new create edit update])

  post('accounting_object_psot', to: 'accounting_object#create', as: 'accounting_object_post')

end
