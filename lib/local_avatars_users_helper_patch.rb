require_dependency 'users_helper'

module LocalAvatarsPlugin
  module UsersHelperPatch
    def self.included(base)
      base.extend(ClassMethods)
      
      base.send(:include, InstanceMethods)
      
      base.class_eval do
        alias_method_chain :user_settings_tabs, :avatar
      end
    end
      
    module ClassMethods
    end
    
    module InstanceMethods
      def user_settings_tabs_with_avatar
        tabs = user_settings_tabs_without_avatar
        tabs << {:name => 'avatar', :partial => 'users/avatar', :label => :label_avatar}
      end
    end
  end
end
