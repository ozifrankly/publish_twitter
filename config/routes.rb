Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post '/publish_weather' => 'publish#weather'
  # Defines the root path route ("/")
  # root "articles#index"
end
