class Bidding < ActiveRecord::Base

  def bidding
    params[:update][:bidding].each do |t|
      @bidding=self.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"], phone: t["phone"])
      if @bidding==nil
        @bidding=self.new(t)
        message_save(@bidding)
      else
        @bidding.delete()
        @bidding=self.new(t)
        message_save(@bidding)
      end
    end
  end
end
