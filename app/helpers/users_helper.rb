module UsersHelper
  def get_format(params)
    @format=params[:format]
  end

  def get_password(user_params)
    @password=user_params[:password]
  end

  def get_password_confirmation(user_params)
    user_params[:password_confirmation]
  end

  def name(user_params)
    user_params[:name]
  end

  def get_user_name(params)
    params[:users][:name]
  end
end
