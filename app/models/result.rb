class Result < ActiveRecord::Base
  def result
    params[:update][:result].each do |t|
      @result=self.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"])
      if @result==nil
        @result=self.new(t)
        message_save(@result)
      else
        @result["name"]=t["name"]
        @result["price"]=t["price"]
        @result["phone"]=t["phone"]
        message_save(@result)
      end
    end
  end
end
