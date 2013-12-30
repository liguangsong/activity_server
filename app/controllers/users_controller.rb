# coding: utf-8
class UsersController < ApplicationController

  def new
    @name = params[:format]
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if user_params[:password]==user_params[:password_confirmation]
      if @user.save
        if params[:format] == 'admin'
          redirect_to admin_path('1')
        else
          render 'show'
        end
      else
        render 'new'
      end
    else
      flash[:error]="两次密码不一致"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:users).permit(:name,:password,:answer,:question)
  end

end
