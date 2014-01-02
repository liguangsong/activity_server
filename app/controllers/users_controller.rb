# coding: utf-8
class UsersController < ApplicationController

  def new
    @name = params[:format]
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if User.find_by(name:user_params[:name])==nil
      return repair_password
    end
    return user_name_exist

  end

  def repair_password
    if user_params[:password]==user_params[:password_confirmation]
      return user_is_or_not_save
    end
      flash[:error]="两次密码不一致"
      render 'new'
  end

  def user_is_or_not_save
    if @user.save
      session[:user]=@user[:name]
      redirect_to user_path(@user[:id])
      return
    end
      render 'new'
      return
  end

  def user_name_exist
    flash[:error]='用户名已经存在'
    render 'new'
  end

  def show
    @user = User.find(params[:id])
  end

  def forget_password_page

  end

  private
  def user_params
    params.require(:users).permit(:name,:password,:password_confirmation,:answer,:question)
  end

end
