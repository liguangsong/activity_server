class SignUp < ActiveRecord::Base
  def self.sign_up(params)
    if params[:update][:sign_up]!=nil
    params[:update][:sign_up].each do |t|
      @sign_up=SignUp.find_by(user: t["user"], activity_name: t["activity_name"], phone: t["phone"])
      if @sign_up==nil
        @sign_up=SignUp.new(t)
        Activity.message_save(@sign_up)
      end
     end
    end
  end
end
