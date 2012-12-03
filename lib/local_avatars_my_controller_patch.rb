require_dependency 'my_controller'

module LocalAvatarsPlugin
  module MyControllerPatch
    def self.included(base)
      base.extend(ClassMethods)
      
      base.send(:include, InstanceMethods)
      
      base.class_eval do
        helper :attachments
        include AttachmentsHelper
      end

    end
      
    module ClassMethods
    end
    
    module InstanceMethods
      include LocalAvatars

      def avatar
        @user = User.current
      end

      def save_avatar
        @user = User.current
        begin
          save_or_delete # see the LocalAvatars module
        rescue => e
          flash[:error] = @possible_error || e.message
        end
        redirect_to :action => 'avatar'
      end      
    end
  end
end

