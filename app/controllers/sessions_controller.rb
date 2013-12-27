class SessionsController < ApplicationController

  def new

  end

  def errors
    @errors ||= Errors.new(self)
  end

  def  create
    name= params[:session][:name].to_s;
    password= params[:session][:password].to_s;
    @user=Admin.find_by(name:name)
    if @user==nil
      flash.now[:error]='error'
      render 'new'
    else
      if password==@user[:password]
        redirect_to admin_path(@user[:id])
      else
        flash.now[:error]='error'
        render action:'new'
      end
    end
  end



end
