class Activity < ActiveRecord::Base
  def activity
    params[:update][:activity].each do |t|
      @activity=self.find_by(user_name: t["user_name"], activity_name: t["activity_name"])
      if @activity==nil
        @activity_of_user=self.new(t)
        message_save(@activity_of_user)
      else
        @activity["sign_up_number"]=t["sign_up_number"]
        @activity["bid_number"]=t["bid_number"]
        message_save(@activity)
      end
    end
  end
end
