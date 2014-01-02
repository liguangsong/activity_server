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

  def compare_question_page

  end

  def confirm_user_name
     @user=User.find_by(name:params[:users][:name])
    if @user!=nil
       session[:id_of_the_forget_password_user]=@user[:id]
       redirect_to  users_compare_question_page_path
      return
    else
       flash[:error]='账号不存在'
       render 'forget_password_page'
    end
  end

  def compare_question_page
    flash[:error]=''
    @user=User.find_by(id: session[:id_of_the_forget_password_user])
  end

  def compare_question
    @user=User.find_by(id: session[:id_of_the_forget_password_user])
    if @user[:answer]==params[:users][:answer]
     redirect_to users_change_password_page_path
    else
      flash[:error]='密保答案不正确'
      render 'compare_question_page'

    end
  end

  def change_password_page
    flash[:error]=''
    @user=User.find_by(id: session[:id_of_the_forget_password_user])
  end

  def change_password
    @user=User.find_by(id: session[:id_of_the_forget_password_user])
    if params[:users][:password]==params[:users][:password_confirmation]
      @user[:password]=params[:users][:password]
      @user[:password_confirmation]=params[:users][:password_confirmation]
      change_password_is_or_not_save
    else
      flash[:error]="两次密码不一致"
    end
  end

  def change_password_is_or_not_save
    if @user.save
      session[:user]=@user[:name]
      render 'show'
    else
      render 'change_password_page'
    end
  end

  private
  def user_params
    params.require(:users).permit(:name,:password,:password_confirmation,:answer,:question)
  end

end
