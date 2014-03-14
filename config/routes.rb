PsychicOctoHipster::Application.routes.draw do

  resources :posts

  root :to => "home#index"
  get "/resume" => "resume#index"
  get "/booklist" => "booklist#index"
  get "/irs" => "irs#index"
  get "/gallery" => "gallery#index"
  get "/places" => "places#index"
  
  resources :covers
  resources :pictures
end
