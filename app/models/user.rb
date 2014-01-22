# coding: utf-8
class User < ActiveRecord::Base

  validates_presence_of :name, :message => "用户名不能为空"
  validates_length_of :name, :in => 1..10, :message => "用户名长度不正确"
  validates_presence_of :password, :message => "密码不能为空"
  validates_length_of :password, :in => 1..10, :message => "密码长度不正确"
  validates_presence_of :question, :message => "密保问题不能为空"
  validates_length_of :question, :in => 1..10, :message => "密保问题长度不正确"
  validates_presence_of :answer, :message => "答案不能为空"
  validates_length_of :answer, :in => 1..10, :message => "答案长度不正确"

  def self.name_empty?(params)
    if params[:session][:name]==''
      return "name_empty"
    end
    return User.is_or_not_input_password(params[:session][:name], params[:session][:password])
  end

  def self.is_or_not_input_password(name, password)
    if password==''
      return "password_empty"
    end
    return User.user_name_is_or_not_exist(name, password)
  end

  def self.user_name_is_or_not_exist(name, password)
    admin=Admin.find_by(name: name)
    user=User.find_by(name: name)
    if user==nil&&admin==nil
      return "error"
    end
    return User.name_is_or_not_a_admin(password, admin, user)
  end

  def self.name_is_or_not_a_admin(password, admin, user)
    if admin!=nil&&password==admin[:password]
      @id =admin[:id]
      return {:name => "admin", :message => @id, :session => admin[:name]}
    end
    return User.name_is_or_not_a_user(password, admin, user)
  end

  def self.name_is_or_not_a_user(password, admin, user)
    if user!=nil&&password==user[:password]
      @id =user[:id]
      return {:name => "user", :message => @id, :session => user[:name]}
    else
      return "error"
    end
  end

  def self.name_is_or_not_exist(user_params)
    user = User.new(user_params)
    if User.find_by(name: user_params[:name])==nil
      return User.repair_password(user_params, user)

    end
    return "user_name_exist"
  end

  def self.repair_password(user_params, user)
    if user_params[:password]==user_params[:password_confirmation]
      return User.user_is_or_not_save(user)
    else
      return "two_password_not_same"
    end
  end

  def self.user_is_or_not_save(user)
    return "else"
  end


end
