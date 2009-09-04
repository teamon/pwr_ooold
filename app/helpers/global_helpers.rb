module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    
    def format_datetime(datetime)
      datetime.respond_to?(:strftime) ? datetime.strftime("%Y-%m-%d %H:%M") : ""
    end
    
    def human_size(size)
      Merb.logger.d size
      size = Float(size)
      suffix = %w(B KB MB GB TB)
      max_exp = suffix.size - 1
      exp = (Math.log(size) / Math.log(1024)).to_i
      exp = max_exp if exp > max_exp
      size /= 1024 ** exp
      "#{"%.2f" % size} #{suffix[exp]}"
    end
    
    def link_to_image(image)
      link_to tag(:div, 
        image_tag(image.url(:thumbnail)) +
        tag(:span, 
          image.filename + " " +
          human_size(image.size)
        )
      ), image.url, :title => image.filename, :class => "img", :rel => "photos"
    end
    
  end
end
