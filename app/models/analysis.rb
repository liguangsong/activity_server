class Analysis < ActiveRecord::Base
  def self.analysis(params)
    if params[:update][:analysis]!=nil
      params[:update][:analysis].each do |t|
        @analysis=Analysis.find_by(user: t["user"], activity_name: t["activity_name"], bid_name: t["bid_name"], price: t["price"])
        if @analysis==nil
          @analysis=Analysis.new(t)
          Activity.message_save(@analysis)
        else
          @analysis["number"]=t["number"]
          Activity.message_save(@analysis)
        end
      end
    end
  end
end
