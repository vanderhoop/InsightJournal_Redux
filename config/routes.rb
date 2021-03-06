InsightJournalRedux::Application.routes.draw do

  devise_for :users
  devise_scope :user do
    post "/users/sign_out" => "devise/sessions#destroy"
  end

  root :to => "welcome#index"
  get "/users/:id/insights" => "welcome#insights", :as => "insights"
  get "/users/:id/new-insights" => "welcome#new_insights", :as => "insights_json"

  resources :users do
    resources :entries
  end

end
# == Route Map (Updated 2013-12-19 11:22)
#
#         new_user_session GET    /users/sign_in(.:format)                   devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                   devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                  devise/sessions#destroy
#            user_password POST   /users/password(.:format)                  devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)              devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)             devise/passwords#edit
#                          PUT    /users/password(.:format)                  devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                    devise/registrations#cancel
#        user_registration POST   /users(.:format)                           devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                   devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                      devise/registrations#edit
#                          PUT    /users(.:format)                           devise/registrations#update
#                          DELETE /users(.:format)                           devise/registrations#destroy
#           users_sign_out POST   /users/sign_out(.:format)                  devise/sessions#destroy
#                     root        /                                          welcome#index
#                          GET    /users/:id/insights(.:format)              welcome#insights
#                          GET    /users/:id/new-insights(.:format)          welcome#new_insights
#             user_entries GET    /users/:user_id/entries(.:format)          entries#index
#                          POST   /users/:user_id/entries(.:format)          entries#create
#           new_user_entry GET    /users/:user_id/entries/new(.:format)      entries#new
#          edit_user_entry GET    /users/:user_id/entries/:id/edit(.:format) entries#edit
#               user_entry GET    /users/:user_id/entries/:id(.:format)      entries#show
#                          PUT    /users/:user_id/entries/:id(.:format)      entries#update
#                          DELETE /users/:user_id/entries/:id(.:format)      entries#destroy
#                    users GET    /users(.:format)                           users#index
#                          POST   /users(.:format)                           users#create
#                 new_user GET    /users/new(.:format)                       users#new
#                edit_user GET    /users/:id/edit(.:format)                  users#edit
#                     user GET    /users/:id(.:format)                       users#show
#                          PUT    /users/:id(.:format)                       users#update
#                          DELETE /users/:id(.:format)                       users#destroy
#
