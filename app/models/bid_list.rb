class BidList < ActiveRecord::Base
  def self.bid_list(params)
    if params[:update][:bid_list]!=nil
      params[:update][:bid_list].each do |t|
        @bid_list=BidList.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"])
        if @bid_list==nil
          @bid_list=BidList.new(t)
          Activity.message_save(@bid_list)
        else
          @bid_list.delete()
          @bid_list=BidList.new(t)
          Activity.message_save(@bid_list)
        end
      end
    end
  end
end
