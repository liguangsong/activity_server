# coding: utf-8
class SessionsController < ApplicationController

  def new
    flash[:error]=''
  end

  def errors
    @errors ||= Errors.new(self)
  end

  def create
    case User.name_empty?(params)
      when "error"
        @error="true"
       return render 'new'
      when 'name_empty'
        @error="name_empty"
        return render "new"
      when  'password_empty'
        @error="password_empty"
        return render "new"
      else
        return login_in(User.name_empty?(params))
    end
  end

  def login_in(message)
    if message[:name]=="admin"
        session[:admin]=User.name_empty?(params)[:session]
        return redirect_to admin_path(message[:message])
    else
        session[:user]=message[:session]
        return redirect_to user_path(message[:message])
    end
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






