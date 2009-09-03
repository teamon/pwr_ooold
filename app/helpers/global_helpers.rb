module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    
    def format_datetime(datetime)
      datetime.respond_to?(:strftime) ? datetime.strftime("%Y-%m-%d %H:%M") : ""
    end
    
    def time_select(name)
      select(:collection => (0..23).map {|e| e.to_s.rjust(2, "0") }) +
      ":" + select(:collection => (0..12).map {|e| (e*5).to_s.rjust(2, "0") })
    end
  end
end
