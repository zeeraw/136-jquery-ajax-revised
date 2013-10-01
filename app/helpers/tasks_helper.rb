module TasksHelper

  def task_user_select_options
    options = User.all.map do |user|
      opts = []
      opts[0] = current_user == user ? "#{user.name} (Me)" : user.name
      opts[1] = user.id
      opts
    end
  end

end
