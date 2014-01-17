# coding: utf-8
class SessionsController < ApplicationController

  def new
    flash[:error]=''
  end

  def errors
    @errors ||= Errors.new(self)
  end

  def create
    name= params[:session][:name];
    password= params[:session][:password]
    if (name==nil)
      flash.now[:error]='请输入用户名'
      render 'new'
    else
      return is_or_not_input_password(name, password)
    end
  end

  def is_or_not_input_password(name, password)
    if password==nil
      flash.now[:error]='请输入密码'
      render 'new'
      return
    end
    return user_name_is_or_not_exist(name, password)
  end

  def user_name_is_or_not_exist(name, password)
    @admin=Admin.find_by(name: name)
    @user=User.find_by(name: name)
    if @user==nil&&@admin==nil
      flash.now[:error]='用户名或密码不正确'
      render 'new'
      return
    end
    if @admin!=nil&&password==@admin[:password]
      session[:admin]=@admin[:name]
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
    user=User.find_by(name: params[:update][:name])
    user_is_or_not_exist(user)
  end

  def user_is_or_not_exist(user)
    if user==nil
      respond_to do |format|
        format.json { render :json => 'false' }
      end
    else
      user_password_is_or_not_correct(user)
    end
  end

  def user_password_is_or_not_correct(user)
    password=params[:update][:password]
    if (password==user[:password])
      respond_to do |format|
        format.json { render :json => 'true' }
      end
    else
      respond_to do |format|
        format.json { render :json => 'false' }
      end
    end

  end

  def update
    Activity.transaction do
      Activity.activity()
      SignUp.sign_up()
      Bidding.bidding()
      BidList.bid_list()
      Analysis.analysis()
      Result.result()
    end
    respond_to do |format|
      format.json { render :json => 'true' }
    end
  end

  def message_save(message)
    if !message.save()
      respond_to do |format|
        format.json { render :json => 'false' }
      end
    end

  end

  private

  def activity_params
    params.require(:update).permit(:activity, :sign_up, :bidding_page, :analysis, :result)
  end


end






