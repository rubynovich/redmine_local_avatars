module LocalAvatarsPlugin
  module LocalAvatars
    def send_avatar(user)
      expires_in 1.month
      av = user.avatar
      if av && thumbnail = av.diskfile
        send_file(thumbnail, :filename => filename_for_content_disposition(av.filename),
                  :type => av.content_type,
                  :disposition => (av.image? ? 'inline' : 'attachment'))
      else
        # No thumbnail for the attachment or thumbnail could not be created
        render :nothing => true, :status => 404
      end
    end

    def save_or_delete(user = @user)
      if params[:commit] == l(:button_delete)
        @user.avatar.destroy if @user.avatar
        @user.avatar = nil
        @possible_error = l(:unable_to_delete_avatar)
        @user.save!
        flash[:notice] = l(:avatar_deleted)
      else # take anything else as save
        @user.save_attachments(['file' => params[:avatar], 'description' => 'avatar'])
        raise l(:error_file_not_uploaded) unless @user.saved_attachments.any?
        raise l(:error_uploaded_file_is_not_image) unless @user.saved_attachments.first.image?
        @possible_error = l(:error_saving_avatar)
        @user.avatar.destroy if @user.avatar
        @user.avatar = @user.saved_attachments.first
        @user.save!
        flash[:notice] = l(:message_avatar_uploaded)
      end
    end
  end
end
