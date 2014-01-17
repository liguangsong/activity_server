class Analysis < ActiveRecord::Base
  def analysis
    params[:update][:analysis].each do |t|
      @analysis=self.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"],price:t["price"])
      if @analysis==nil
        @analysis=self.new(t)
        message_save(@analysis)
      else
        @analysis["number"]=t["number"]
        message_save(@analysis)
      end
    end
  end
end
