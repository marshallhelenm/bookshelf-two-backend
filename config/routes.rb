Rails.application.routes.draw do
  resources :book_authors
  resources :authors
  resources :shelf_books
  resources :shelves
  resources :books
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
