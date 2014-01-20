class Bidding < ActiveRecord::Base

  def self.bidding(params)
    if params[:update][:bidding]!=nil
      params[:update][:bidding].each do |t|
        @bidding=Bidding.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"], phone: t["phone"])
        if @bidding==nil
          @bidding=Bidding.new(t)
          Activity.message_save(@bidding)
        else
          @bidding.delete()
          @bidding=Bidding.new(t)
          Activity.message_save(@bidding)
        end
      end
    end
  end
end
