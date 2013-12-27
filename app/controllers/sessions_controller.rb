class SessionsController < ApplicationController

  def new

  end

  def  create
    name= params[:session][:name].to_s;
    password= params[:session][:password].to_s;
    @user=User.find_by(name:name)
    if @user==nil
      flash.now[:error]='error'
      render 'new'
    else
      if password==@user[:password]
        redirect_to user_path(@user[:id])
      else
        flash.now[:error]='error'
        render action:'new'
      end
    end
  end



end
