# coding: utf-8
class AdminsController < ApplicationController

  def quit
    check_login
    session[:user]=nil;
    redirect_to new_session_path;
  end

  def check_login
    if session[:user]==nil
      redirect_to new_session_path;
    end
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
    check_login
    @user=User.new
    @id=params[:format]
  end

  def add_new_user
    check_login
    @id=params[:format]
    @user = User.new(user_params)
    name=user_params[:name]
    if User.find_by(name:name)!=nil||Admin.find_by(name:name)!=nil;
      flash[:error]="此用户名不能注册"
      render 'add_new_user_page'
      return
    end
    if user_params[:password]==user_params[:password_confirmation]
          if @user.save
              redirect_to admin_path(@id)
          end
    else
          flash[:error]="两次密码不一致"
          render 'add_new_user_page'
    end

  end

  def show
    @admin = Admin.find('1')
    @user = User.paginate(page: params[:page], per_page: 9)
  end

  def destroy
    check_login
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_path
  end



  private
  def admin_params
    params.require(:admins).permit(:name,:password,:answer,:question)
  end

  def user_params
    params.require(:users).permit(:name,:password,:password_confirmation,:answer,:question)
  end
end
