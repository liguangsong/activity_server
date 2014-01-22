# coding: utf-8
class UsersController < ApplicationController

  before_action :check_user_login, only: [:show, :bid_list_page, :sign_up_page, :bidding_page, :synchronous_show, :synchronous_page]

  def quit
    session[:user]=nil;
    redirect_to new_session_path;
  end

  def check_user_login
    if session[:user]==nil
      redirect_to new_session_path
    end
  end

  def new
    @error=''
    @name = params[:format]
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    case User.name_is_or_not_exist(user_params)
      when "user_name_exist"
        @error="user_name_exist"
        render 'new'
      when "two_password_not_same"
        @error="two_password_not_same"
        render 'new'
      when "else"
        save
    end
  end

  def save
    @user=User.new(user_params)
    if @user.save
      session[:user]=@user["name"]
      return redirect_to user_path(@user["id"])
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @disabled=BidList.find_by(user: @user["name"], status: "start")==nil
    @activity=Activity.paginate(page: params[:page], per_page: 10).where(:user_name => @user["name"])
  end

  def forget_password_page
  end

  def confirm_user_name
    if params[:users][:name]==''
      @error='name_empty'
      render 'forget_password_page'
    else
      user_name_is_or_not_exist
    end
  end

  def user_name_is_or_not_exist
    @user=User.find_by(name: params[:users][:name])
    if @user!=nil
      session[:id_of_the_forget_password_user]=@user[:id]
      return redirect_to users_compare_question_page_path
    else
      @error='name_no_exit'
      render 'forget_password_page'
    end
  end

  def compare_question_page
    @error=''
    @user=User.find_by(id: session[:id_of_the_forget_password_user])
  end

  def compare_question
    @user=User.find_by(id: session[:id_of_the_forget_password_user])
    if @user[:answer]==params[:users][:answer]
      return redirect_to users_change_password_page_path
    else
      @error='answer_error'
      render 'compare_question_page'
    end
  end

  def change_password_page
    @error=""
    @user=User.find_by(id: session[:id_of_the_forget_password_user])
  end

  def change_password
    @user=User.find_by(id: session[:id_of_the_forget_password_user])
    if params[:users][:password]==params[:users][:password_confirmation]
      @user[:password]=params[:users][:password]
      @user[:password_confirmation]=params[:users][:password_confirmation]
      change_password_is_or_not_save
    else
      @error="two_password_not_same"
      render 'change_password_page'
    end
  end

  def change_password_is_or_not_save
    if @user.save
      session[:user]=@user[:name]
      @id=User.find_by(name: @user[:name])
      redirect_to user_path(@id)
    else
      render 'change_password_page'
    end
  end

  def bid_list_page
    @activity_name=params[:format]
    @user=session[:user]
    @id=User.find_by(name: @user)["id"]
    @bid_list=BidList.paginate(page: params[:page], per_page: 10).where(:user => @user, :activity_name => @activity_name)
  end

  def sign_up_page
    @activity_name=params[:format]
    @user=session[:user]
    @id=User.find_by(name: @user)["id"]
    @sign_up=SignUp.paginate(page: params[:page], per_page: 10).where(:user => @user, :activity_name => @activity_name)
  end

  def bidding_page
    @bid_name=params["bid_name"]
    @activity_name=params["activity_name"]
    @user=session[:user]
    @user_id=User.find_by(name: @user)["id"]
    @bid=BidList.find_by(user: @user, activity_name: @activity_name, bid_name: @bid_name)
    @bidding=Bidding.paginate(page: params[:page], per_page: 10).where(:user => @bid["user"], :activity_name => @bid["activity_name"], :bid_name => @bid["bid_name"])
    @analysis=Analysis.paginate(page: params[:page], per_page: 10).where(:user => @bid["user"], :activity_name => @bid["activity_name"], :bid_name => @bid["bid_name"])
    @result=Result.find_by(user: @bid["user"], activity_name: @bid["activity_name"], bid_name: @bid["bid_name"])
  end

  def synchronous_show
    @user_name=session[:user]
    @bid=BidList.find_by(user: @user_name, status: "start")
    if (@bid!=nil)
      session[:synchronous_bid_name]=@bid["bid_name"]
      session[:synchronous_activity_name]=@bid["activity_name"]
      redirect_to users_synchronous_page_path
    else
      @id=User.find_by(name: @user_name)["id"]
      redirect_to user_path(@id)
    end
  end

  def synchronous_page
    @user=session[:user]
    @user_id=User.find_by(name: @user)["id"]
    @bid=BidList.find_by(user: session[:user], activity_name: session[:synchronous_activity_name], bid_name: session[:synchronous_bid_name])
    @bidding=Bidding.paginate(page: params[:page], per_page: 10).where(user: @bid["user"], activity_name: @bid["activity_name"], bid_name: @bid["bid_name"])
    @result=Result.find_by(user: @bid["user"], activity_name: @bid["activity_name"], bid_name: @bid["bid_name"])
  end

  private
  def user_params
    params.require(:users).permit(:name, :password, :password_confirmation, :answer, :question)
  end

end
