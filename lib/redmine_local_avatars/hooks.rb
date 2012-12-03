module RedmineLocalAvatars
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_my_account_contextual,
              :partial => 'hooks/redmine_local_avatars/view_my_account_contextual'
  end
end
