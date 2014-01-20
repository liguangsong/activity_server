# coding: utf-8
class SessionsController < ApplicationController
  include SessionsHelper

  def new
    flash[:error]=''
  end

  def errors
    @errors ||= Errors.new(self)
  end

  def create
    if name_empty?(params[:session][:name])==true
      flash.now[:error]='请输入用户名'
      return render 'new'
    end
    return is_or_not_input_password(params[:session][:name], params[:session][:password])
  end

  def is_or_not_input_password(name, password)
    if password_empty?(password)==true
      flash.now[:error]='请输入密码'
      return render 'new'
    end
    return user_name_is_or_not_exist(name, password)
  end

  def user_name_is_or_not_exist(name, password)
    admin=Admin.find_by(name: name)
    user=User.find_by(name: name)
    if user==nil&&admin==nil
      flash.now[:error]='用户名或密码不正确'
      return render 'new'
    end
    return name_is_or_not_a_admin(password, admin, user)
  end

  def name_is_or_not_a_admin(password, admin, user)
    if admin!=nil&&password==admin[:password]
      session[:admin]=admin[:name]
      return redirect_to admin_path(admin[:id])
    end
    return name_is_or_not_a_user(password, admin, user)
  end

  def name_is_or_not_a_user(password, admin, user)
    if user!=nil&&password==user[:password]
      session[:user]=user[:name]
      redirect_to user_path(user[:id])
    else
      flash.now[:error]='用户名或密码不正确'
      render 'new'
    end
  end

  def name_or_password_error
    flash.now[:error]='用户名或密码不正确'
    render 'new'
  end

  def user_authentication
    user=User.find_by(name: params[:update][:name])
    user_is_or_not_exist(user)
  end

  def user_is_or_not_exist(user)
    if user==nil
      update_error
    else
      user_password_is_or_not_correct(user)
    end
  end

  def user_password_is_or_not_correct(user)
    password=params[:update][:password]
    if (password==user[:password])
      update_success
    else
      update_error
    end
  end

  def update
    Activity.transaction do
      Activity.activity(params)
      SignUp.sign_up(params)
      Bidding.bidding(params)
      BidList.bid_list(params)
      Analysis.analysis(params)
      Result.result(params)
    end
    update_success
  end

  private

  def activity_params
    params.require(:update).permit(:activity, :sign_up, :bidding_page, :analysis, :result)
  end


end






