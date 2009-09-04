module Merb
  module GlobalHelpers
    # helpers defined here available to all views.  
    
    def format_datetime(datetime)
      datetime.respond_to?(:strftime) ? datetime.strftime("%d.%m.%Y %H:%M") : ""
    end
    
    def human_size(size)
      return "0 B" if size == 0
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
    
    def textilize(text)
      RedCloth.new(text).to_html
    end
    
    def datetime_picker(object, field, opts = {})
      name = "#{object.class.to_s.snake_case}[#{field}]"
      sel = object.send(field) || DateTime.now
      
      tag(:span,
        select(:name => "#{name}[day]",   :class => "day",   :selected => sel.day.to_s,                 :collection => (1..31).map{|e|e.to_s}) +
        select(:name => "#{name}[month]", :class => "month", :selected => sel.month.to_s.rjust(2, "0"), :collection => (1..12).map{|e|e.to_s.rjust(2, "0")}) +
        select(:name => "#{name}[year]",  :class => "year",  :selected => sel.year.to_s,                :collection => (2007..2015).map{|e|e.to_s}) +
        select(:name => "#{name}[hour]",  :class => "hour",  :selected => sel.hour.to_s.rjust(2, "0"),  :collection => (0..23).map{|e|e.to_s.rjust(2, "0")}) +
        select(:name => "#{name}[min]",   :class => "min",   :selected => sel.min.to_s,                 :collection => (0..11).map{|e|(e*5).to_s.rjust(2, "0")}),
        :class => "datetime"
      )
    end
    
  end
end
