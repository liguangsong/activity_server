# coding: utf-8
class SessionsController < ApplicationController

  def new
    flash[:error]=''
  end

  def errors
    @errors ||= Errors.new(self)
  end

  def create
    name= params[:session][:name].to_s;
    password= params[:session][:password].to_s;
    if (name=='')
      flash.now[:error]='请输入用户名'
      render 'new'
      return
    else
      return is_or_not_input_password(name, password)
    end
  end

  def is_or_not_input_password(name, password)
    if password==''
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
    activity
    sign_up
    bidding
    bid_list
    analysis
    result
    respond_to do |format|
      format.json { render :json => 'true' }
    end
  end

  def activity
    params[:update][:activity].each do |t|
      @activity=Activity.find_by(user_name: t["user_name"], activity_name: t["activity_name"])
      if @activity==nil
        @activity_of_user=Activity.new(t)
        message_save(@activity_of_user)
      else
        @activity["sign_up_number"]=t["sign_up_number"]
        @activity["bid_number"]=t["bid_number"]
        message_save(@activity)
      end
    end
  end

  def sign_up
    params[:update][:sign_up].each do |t|
      @sign_up=SignUp.find_by(user: t["user"], activity_name: t["activity_name"], phone: t["phone"])
      if @sign_up==nil
        @sign_up=SignUp.new(t)
        message_save(@sign_up)
      end
    end
  end

  def bidding
    params[:update][:bidding].each do |t|
      @bidding=Bidding.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"], phone: t["phone"])
      if @bidding==nil
        @bidding=Bidding.new(t)
        message_save(@bidding)
      else
        @bidding.delete()
        @bidding=Bidding.new(t)
        message_save(@bidding)
      end
    end
  end

  def bid_list
    params[:update][:bid_list].each do |t|
      @bid_list=BidList.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"])
      if @bid_list==nil
        @bid_list=BidList.new(t)
        message_save(@bid_list)
      else
        #@bid_list["number"]=t["number"]
        #@bid_list["status"]=t["status"]
        #@bid_list["sign_up_number"]=t["sign_up_number"]
        @bid_list.delete()
        @bid_list=BidList.new(t)
        message_save(@bid_list)
      end
    end
  end

  def analysis
    params[:update][:analysis].each do |t|
      @analysis=Analysis.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"],price:t["price"])
      if @analysis==nil
        @analysis=Analysis.new(t)
        message_save(@analysis)
      else
        @analysis["number"]=t["number"]
        message_save(@analysis)
      end
      p '-----'
      p @analysis["number"]
      p @analysis["price"]
      p '------'
    end
  end

  def result
    params[:update][:result].each do |t|
      @result=Result.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"])
      if @result==nil
        @result=Result.new(t)
        message_save(@result)
      else
        @result["name"]=t["name"]
        @result["price"]=t["price"]
        @result["phone"]=t["phone"]
        message_save(@result)
      end
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






