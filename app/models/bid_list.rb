class BidList < ActiveRecord::Base
  def bid_list
    params[:update][:bid_list].each do |t|
      @bid_list=self.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"])
      if @bid_list==nil
        @bid_list=self.new(t)
        message_save(@bid_list)
      else
        @bid_list.delete()
        @bid_list=self.new(t)
        message_save(@bid_list)
      end
    end
  end
end
