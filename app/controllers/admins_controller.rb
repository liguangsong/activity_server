# coding: utf-8
class AdminsController < ApplicationController

  def quit
    session[:user]=nil;
    redirect_to new_session_path;
  end

  def check_login
    if session[:user]==nil
      redirect_to new_session_path
    end
    return session[:user]==nil
  end

  def new
    @admin=Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admin_path(@admin[:id])
    end
  end

  def add_new_user_page
    if !check_login
      @user=User.new
      @id=params[:format]
    end
  end

  def add_new_user
    @id=params[:format]
    @user = User.new(user_params)
    name=user_params[:name]
    if !check_login
      return name_is_or_not_exist(name)
    end
  end

  def name_is_or_not_exist(name)
    if User.find_by(name: name)!=nil||Admin.find_by(name: name)!=nil;
      flash[:error]="此用户名已存在"
      render 'add_new_user_page'
      return
    end
    return password_is_or_not_some
  end

  def password_is_or_not_some
    if user_params[:password]==user_params[:password_confirmation]
      user_is_or_not_save
    else
      flash[:error]="两次密码不一致"
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
    if !check_login
      @user.destroy
      redirect_to admin_path
    end
  end

  def repair_user_password_page
    @user=User.find_by(id: params[:format])
    if !check_login
      @id=Admin.find_by(name: session[:user])[:id]
    end
  end

  def repair_user_password
    @id=session[:user]
    name=params[:format]
    @user=User.find_by(name: name)
    if !check_login
      repair_password_is_or_not_some
    end
  end

  def repair_password_is_or_not_some
    if params[:users_password][:password]==params[:users_password][:password_confirmation]
      @user[:password]= params[:users_password][:password]
      repair_password_is_or_not_empty
    else
      flash[:error]="两次密码不一致"
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
