require_dependency 'users_controller'

module LocalAvatarsPlugin
  module UsersControllerPatch
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

      def get_avatar
        @user = User.find(params[:id])
        send_avatar(@user)
      end

      def save_avatar
        @user = User.find(params[:id])

        begin
          save_or_delete # see the LocalAvatars module
        rescue => e
          flash[:error] = @possible_error || e.message
        end
        redirect_to :action => 'edit', :id => @user, :tab => "avatar"
      end
    end
  end
end

