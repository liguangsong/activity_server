module SessionsHelper
  def get_name(params)
    @name=params[:session][:name]
  end

  def get_password (params)
    @password=params[:session][:password]
  end

  def name_empty?(name)
      name==""
  end

  def password_empty?(password)
     password==""
  end

end
