# coding: utf-8
class AdminsController < ApplicationController
  before_action :check_admin_login, only: [:new, :create, :add_new_user_page, :add_new_user, :show, :destroy, :repair_user_password_page, :repair_user_password, :show_user_activity]

  def check_admin_login
    if session[:admin]==nil
      redirect_to new_session_path
    end
  end

  def quit
    session[:admin]=nil;
    redirect_to new_session_path;
  end

  def new
    @admin=Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admin_path(@admin[:id])
      return
    end
  end

  def add_new_user_page
    @error=''
    @user=User.new
    @id=Admin.find_by(name: session[:admin])["id"]
  end

  def add_new_user

    @id=Admin.find_by(name: session[:admin])["id"]
    @user = User.new(user_params)
    name=user_params[:name]
    return name_is_or_not_exist(name)
  end

  def name_is_or_not_exist(name)
    if User.find_by(name: name)!=nil||Admin.find_by(name: name)!=nil;
      @error="user_name_exist"
      render 'add_new_user_page'
      return
    end
    return password_is_or_not_some
  end

  def password_is_or_not_some
    if user_params[:password]==user_params[:password_confirmation]
      user_is_or_not_save
    else
      @error="two_password_not_same"
      render 'add_new_user_page'
      return
    end
  end

  def user_is_or_not_save
    if @user.save
      redirect_to admin_path(@id)
      return
    else
      render 'add_new_user_page'
      return
    end
  end

  def show
    @admin = Admin.find('1')
    @user = User.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_path
    return
  end

  def repair_user_password_page
    @user=User.find_by(id: params[:format])
    @id=Admin.find_by(name: session[:admin])[:id]
  end

  def repair_user_password
    @id=session[:admin]
    @name=params[:format]
    @user=User.find_by(name: @name)
    repair_password_is_or_not_some
  end

  def repair_password_is_or_not_some
    if params[:users_password][:password]==params[:users_password][:password_confirmation]
      @user[:password]= params[:users_password][:password]
      @user[:password_confirmation]=params[:users_password][:password_confirmation]
      repair_password_is_or_not_empty
    else
      @error="two_password_not_same"
      render 'repair_user_password_page'
      return
    end
  end

  def repair_password_is_or_not_empty
    if @user.save
      redirect_to admin_path(@id)
      return
    else
      render 'repair_user_password_page'
      return
    end
  end

  def show_user_activity
    session[:user]=params[:format]
    id=User.find_by(name: params[:format])
    redirect_to user_path(id)
    return
  end

  private
  def admin_params
    params.require(:admins).permit(:name, :password, :password_confirmation, :answer, :question)
  end

  def user_params
    params.require(:users).permit(:name, :password, :password_confirmation, :answer, :question)
  end

  def users_password
    params.require(:users_password).permit(:password, :password_confirmation)
  end

end
