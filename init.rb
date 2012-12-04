require 'redmine'
#require 'redmine_local_avatars/hooks'
require 'redmine_local_avatars/local_avatars'

if Rails::VERSION::MAJOR < 3
  require 'dispatcher'
  object_to_prepare = Dispatcher
else
  object_to_prepare = Rails.configuration
end

object_to_prepare.to_prepare do
  [ 
#    :account_controller, 
    :application_helper, 
#    :my_controller, 
    :user, 
    :users_controller, 
    :users_helper].each do |cl|
    require "local_avatars_#{cl}_patch"
  end

  [ 
#    [AccountController, LocalAvatarsPlugin::AccountControllerPatch],
    [ApplicationHelper, LocalAvatarsPlugin::ApplicationHelperPatch],
#    [MyController, LocalAvatarsPlugin::MyControllerPatch],
    [User, LocalAvatarsPlugin::UserPatch],     
    [UsersController, LocalAvatarsPlugin::UsersControllerPatch],
    [UsersHelper, LocalAvatarsPlugin::UsersHelperPatch]
  ].each do |cl, patch|
    cl.send(:include, patch) unless cl.included_modules.include? patch
  end
end

Redmine::Plugin.register :redmine_local_avatars do
  name 'Загрузка персонального аватара'
  author 'Roman Shipiev'
  description 'Позволяет из интерфейса администрирования пользователей добавлять аватарки'
  version '0.0.2'
end
