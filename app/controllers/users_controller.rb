class UsersController < ApplicationController

  def new
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_path('1')
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:users).permit(:name,:password,:answer,:question)
  end

end
