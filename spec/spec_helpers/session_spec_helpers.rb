module ControllerSessionHelpers

  def login_as_user(user=nil)
    user ||= create(:user)
    subject.authenticate! user

    @request.cookie_jar.signed[:auth_token] = {
      :domain =>  Figaro.env.session_key,
      :value =>   user.auth_token,
      :expires => 20.years.from_now
    }

    return user
  end

  def logout
    request.cookies[:auth_token] = nil
    subject.repudiate!
  end

end

def for_session_by(*session_types,&blk)
  session_types.each do |session_type|
    example_group_class = context "for session by #{session_type.to_s}" do
      case session_type
      when :user
        before(:each) { login_as_user }
      when :guest
        before(:each) { logout }
      else
      end
    end
    example_group_class.class_eval &blk if blk
  end
end