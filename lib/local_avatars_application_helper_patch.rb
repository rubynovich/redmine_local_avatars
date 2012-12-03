require_dependency 'application_helper'

module LocalAvatarsPlugin
  module ApplicationHelperPatch
    def self.included(base)
      base.extend(ClassMethods)
      
      base.send(:include, InstanceMethods)
      
      base.class_eval do
        alias_method_chain :avatar, :local
      end

    end
      
    module ClassMethods
    end
    
    module InstanceMethods
      def avatar_with_local(user, options = {})            
        if user.is_a?(User) && user.avatar_id
          options[:size] = "64" unless options[:size]
          image_url = url_for :only_path => false, :controller => 'account', :action => 'avatar', :id => user, :size => options[:size], :digest => user.avatar.digest
          content_tag :img, nil, :class => "gravatar", :width => options[:size], :height => options[:size], :src => image_url
        else
          options.merge!({:ssl => (defined?(request) && request.ssl?), :default => Setting.gravatar_default})
          email = nil
          if user.respond_to?(:mail)
            email = user.mail
          elsif user.to_s =~ %r{<(.+?)>}
            email = $1
          end
          return gravatar(email.to_s.downcase, options) unless email.blank? rescue nil
        end
      end
    end
  end
end
