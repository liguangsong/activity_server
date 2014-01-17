# coding: utf-8
class UsersController < ApplicationController

  def new
    flash[:error]='';
    @name = params[:format]
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if User.find_by(name: user_params[:name])==nil
      return repair_password
    end
    return user_name_exist

  end

  def repair_password
    if user_params[:password]==user_params[:password_confirmation]
      return user_is_or_not_save
    else
      flash[:error]="两次密码不一致"
      render 'new'
    end
  end

  def user_is_or_not_save
    if @user.save
      session[:user]=@user[:name]
      redirect_to user_path(@user[:id])
    else
      render 'new'
    end
  end

  def user_name_exist
    flash[:error]='用户名已经存在'
    render 'new'
  end

  def quit
    session[:user]=nil;
    redirect_to new_session_path;
  end

  def check_user_login
    if session[:user]==nil
      redirect_to new_session_path
    end
    return session[:user]==nil
  end

  def show
    if !check_user_login
      @user = User.find_by(id: params[:id])
      @disabled=BidList.find_by(user: @user["name"], status: "start")==nil
      @activity=Activity.paginate(page: params[:page], per_page: 10).where(:user_name => @user["name"])
    end
  end

  def forget_password_page

  end

  def confirm_user_name
    if params[:users][:name]==''
      flash[:error]='账号不能为空'
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
      render 'change_password_page'
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

  def bid_list_page
    if !check_user_login
      @activity_name=params[:format]
      @user=session[:user]
      @id=User.find_by(name: @user)["id"]
      @bid_list=BidList.paginate(page: params[:page], per_page: 10).where(:user => @user, :activity_name => @activity_name)
    end
  end

  def sign_up_page
    if !check_user_login
      @activity_name=params[:format]
      @user=session[:user]
      @id=User.find_by(name: @user)["id"]
      @sign_up=SignUp.paginate(page: params[:page], per_page: 10).where(:user => @user, :activity_name => @activity_name)
    end
  end

  def bidding_page
    if !check_user_login
      @id=params[:format]
      @user=session[:user]
      @user_id=User.find_by(name: @user)["id"]
      @bid=BidList.find_by(id: @id)
      @bid_name=@bid["bid_name"]
      @activity_name=@bid["activity_name"]
      if session[:list]==nil||session[:list]=="bidding_list"
        @bidding_list=true
        @analysis_list=false
      else
        @bidding_list=false
        @analysis_list=true
      end
      @activity_name=@bid["activity_name"]
      @bidding=Bidding.paginate(page: params[:page], per_page: 10).where(:user => @bid["user"], :activity_name => @bid["activity_name"], :bid_name => @bid["bid_name"])
      @analysis=Analysis.paginate(page: params[:page], per_page: 10).where(:user => @bid["user"], :activity_name => @bid["activity_name"], :bid_name => @bid["bid_name"])
      @result=Result.find_by(user: @bid["user"], activity_name: @bid["activity_name"], bid_name: @bid["bid_name"])
    end

  end

  def bidding_list
    if !check_user_login
      @activity_name=params[:format]
      session[:list]="bidding_list"
      redirect_to users_bidding_page_path(@activity_name)
    end

  end

  def analysis_list
    @activity_name=params[:format]
    session[:list]="ananlysis_list"
    redirect_to users_bidding_page_path(@activity_name)

  end

  def synchronous_show
    @user_name=session[:user]
    @bid=BidList.find_by(user: @user_name, status: "start")
    if(@bid!=nil)
      session[:synchronous_bid_name]=@bid["bid_name"]
      session[:synchronous_activity_name]=@bid["activity_name"]
      redirect_to users_synchronous_page_path
    else
       @id=User.find_by(name:@user_name)["id"]
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
