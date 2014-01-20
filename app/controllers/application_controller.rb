class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #class FooController < ApplicationController
  #  protect_from_forgery :except => :index
  #
  #  # you can disable csrf protection on controller-by-controller basis:
  #  skip_before_filter :verify_authenticity_token
  #end
  def update_error
    respond_to do |format|
      format.json { render :json => 'false' }
    end
  end

  def update_success
    respond_to do |format|
      format.json { render :json => 'true' }
    end
  end

end
