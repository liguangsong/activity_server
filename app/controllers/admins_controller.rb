class AdminsController < ApplicationController
  def new
    @admin=Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to @admin
    else
      render 'new'
    end
  end

  def show
    @admin = Admin.find(params[:id])
    @user = User.paginate(page: params[:page], per_page: 9)
  end

  private
  def admin_params
    params.require(:admins).permit(:name,:password,:answer,:question)
  end
end
