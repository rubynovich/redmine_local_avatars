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
    :account_controller,
    :application_helper,
#    :my_controller,
    :user,
    :users_controller,
    :users_helper].each do |cl|
    require "local_avatars_#{cl}_patch"
  end

  [
    [AccountController, LocalAvatarsPlugin::AccountControllerPatch],
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
  name 'Local Avatars'
  author 'Roman Shipiev'
  description 'This plugin allows Redmine users to upload a picture to be used as an avatar (instead of depending on images from Gravatar).'
  version '0.0.2'
end
