Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'index#welcome'
  post '/:id_org/:title', to: 'index#get_data', as: 'get_data'
  get '/:id_org', to: 'index#show_data', as: 'show_data'
  get 'files/:file', to: 'index#download_zip', as: 'download_zip'
end
