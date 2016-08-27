module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_date(options={})
  	if options[:due]
      options[:due].strftime("%D")
    elsif options[:start_date] && options[:end_date]
      dates = @start_date.strftime("%D") if @start_date
      dates << " -- " + @end_date.strftime("%D") if @end_date
    elsif options[:start_date]
      dates = options[:start_date].strftime("%D") if @start_date
    else
      return "N/A"
    end
  end

  def format_priority(priority)
  	if priority == "high"
      value = " ⇧".colorize(:red)
    elsif priority == "medium"
      value = " ⇨".colorize(:yellow)
    elsif priority == "low"
      value = " ⇩".colorize(:green)
    elsif !priority
      value = ""
    else
      raise UdaciListErrors::InvalidPriorityValueError, "not a valid priority"
    end
    return value
  end

  def type
  	class_name = self.class.name.downcase
  	class_name.slice! "item"
  	return class_name
  end
end
