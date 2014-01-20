class Result < ActiveRecord::Base
  def self.result(params)
    if params[:update][:result]!=nil
      params[:update][:result].each do |t|
        @result=Result.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"])
        if @result==nil
          @result=Result.new(t)
          Activity.message_save(@result)
        else
          @result["name"]=t["name"]
          @result["price"]=t["price"]
          @result["phone"]=t["phone"]
          Activity.message_save(@result)
        end
      end
    end
  end
end
