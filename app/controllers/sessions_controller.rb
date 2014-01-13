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
  end

  def is_or_not_input_password(name,password)
    if password==''
      flash.now[:error]='请输入密码'
      render 'new'
      return
    end
    return user_name_is_or_not_exist(name,password)
  end

  def user_name_is_or_not_exist(name,password)
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

  def user_authentication
    user=User.find_by(name:params[:update][:name])
    user_is_or_not_exist(user)
  end

  def user_is_or_not_exist(user)
    if user==nil
     respond_to do |format|
       format.json { render :json=>'false' }
     end
    else
      user_password_is_or_not_correct(user)
    end
  end

  def user_password_is_or_not_correct(user)
     password=params[:update][:password]
    if(password==user[:password])
      respond_to do |format|
      format.json { render :json=>'true' }
      end
    else
      respond_to do |format|
        format.json { render :json=>'false' }
      end
    end

  end

  def update
    params[:update][:activity].each do |t|
      @activity=Activity.find_by(user_name:t["user_name"],activity_name:t["activity_name"])
      if @activity==nil
        Activity.new(t)
      else
         @activity["sign_up_number"]=t["sign_up_number"]
         redirect_to "/admins/show"
      end
    end
    p '-------------'

    p '----------'



  end

  private
  def activity_params
    params.require(:update).permit(:activity, :sign_up, :bid_list,:bidding,:analysis,:sort )
  end



end






