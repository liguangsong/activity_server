class SessionsController < ApplicationController

  def new

  end

  def errors
    @errors ||= Errors.new(self)
  end

  def  create
    name= params[:session][:name].to_s;
    password= params[:session][:password].to_s;
    @admin=Admin.find_by(name:name)
    @user=User.find_by(name:name)
    if @user==nil&&@admin==nil
      flash.now[:error]='error'
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
      flash.now[:error]='error'
      render 'new'
    end
  end
end





