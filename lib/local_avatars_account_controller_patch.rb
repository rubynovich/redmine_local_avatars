require_dependency 'account_controller'

module LocalAvatarsPlugin
  module AccountControllerPatch
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
        @user = User.find(params[:id])
        send_avatar(@user)
      end
    end
  end
end
