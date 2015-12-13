Rails.application.routes.draw do
  mount Ganttin::API::Main => '/api'

  get '*q', to: 'ganttin/application#not_found'
end
