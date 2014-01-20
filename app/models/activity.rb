class Activity < ActiveRecord::Base
  def self.activity(params)
    params[:update][:activity].each do |t|
      @activity=Activity.find_by(user_name: t["user_name"], activity_name: t["activity_name"])
      if @activity==nil
        @activity_of_user=Activity.new(t)
        Activity.message_save(@activity_of_user)
      else
        @activity["sign_up_number"]=t["sign_up_number"]
        @activity["bid_number"]=t["bid_number"]
        Activity.message_save(@activity)
      end
    end
  end

  def self.message_save(message)
    if !message.save()
      respond_to do |format|
        format.json { render :json => 'false' }
      end
    end

  end
end
