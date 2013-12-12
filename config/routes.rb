InsightJournalRedux::Application.routes.draw do

  root :to => "welcome#index"

  resources :users do
    resources :entries
  end

end
