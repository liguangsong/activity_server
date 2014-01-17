class SignUp < ActiveRecord::Base
  def sign_up
    params[:update][:sign_up].each do |t|
      @sign_up=self.find_by(user: t["user"], activity_name: t["activity_name"], phone: t["phone"])
      if @sign_up==nil
        @sign_up=self.new(t)
        message_save(@sign_up)
      end
    end
  end
end
