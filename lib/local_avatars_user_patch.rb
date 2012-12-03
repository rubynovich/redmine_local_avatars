require_dependency 'principal'
require_dependency 'user'

module LocalAvatarsPlugin
  module UserPatch
    def self.included(base)
      base.class_eval do
			  acts_as_attachable
        belongs_to :avatar, :class_name => 'Attachment', :foreign_key => :avatar_id
      end
    end  
  end
end

