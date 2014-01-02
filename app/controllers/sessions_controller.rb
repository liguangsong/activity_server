# coding: utf-8
class SessionsController < ApplicationController

  def new
     flash[:error]=''
  end

  def errors
    @errors ||= Errors.new(self)
  end

  def  create
    name= params[:session][:name].to_s;
    password= params[:session][:password].to_s;
    if(name=='')
      flash.now[:error]='请输入用户名'
      render 'new'
      return
    else
      return is_or_not_input_password(name,password)
    end
    #
    #
    #@admin=Admin.find_by(name:name)
    #@user=User.find_by(name:name)
    #if @user==nil&&@admin==nil
    #  flash.now[:error]='用户名或密码不正确'
    #  render 'new'
    #  return
    #end
    #if @admin!=nil&&password==@admin[:password]
    #    session[:user]=@admin[:name]
    #    redirect_to admin_path(@admin[:id])
    #    return
    #end
    #if @user!=nil&&password==@user[:password]
    #   session[:user]=@user[:name]
    #   redirect_to user_path(@user[:id])
    #  return
    #  else
    #  flash.now[:error]='用户名或密码不正确'
    #  render 'new'
    #end
  end

  def is_or_not_input_password(name,password)
    if password==''
      flash.now[:error]='请输入密码'
      render 'new'
      return
    end
    return user_name_is_or_nor_exist(name,password)
  end

  def user_name_is_or_nor_exist(name,password)
    @admin=Admin.find_by(name:name)
    @user=User.find_by(name:name)
    if @user==nil&&@admin==nil
      flash.now[:error]='用户名或密码不正确'
      render 'new'
      return
    end
    if @admin!=nil&&password==@admin[:password]
      session[:user]=@admin[:name]
      redirect_to admin_path(@admin[:id])
      return
    end
    if @user!=nil&&password==@user[:password]
      session[:user]=@user[:name]
      redirect_to user_path(@user[:id])
      return
    else
      flash.now[:error]='用户名或密码不正确'
      render 'new'
    end
  end
end





