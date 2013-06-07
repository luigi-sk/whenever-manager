Rails.application.routes.draw do

  mount WheneverManager::Engine => "/whenever_manager", :as => :whenever_manager
end
