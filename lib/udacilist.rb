class UdaciList
  include UdaciListErrors
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
    @type = options[:type]
    @completed_items = []
  end
  def add(type, description, options={})
    type = type.downcase
    if type.include?("todo") || type.include?("event") || type.include?("link")
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
    else
      raise UdaciListErrors::InvalidItemType, "#{type} is not supported."
    end
  end

  def change_list_title(new_title)
    @title = new_title
  end

  def delete(index)
    if index <= @items.count
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize
    end 
  end
  def make_title(title)
    title_ascii = Artii::Base.new 
    puts title_ascii.asciify(title)
  end
  def all
    puts "-" * @title.length
    puts make_title(@title)
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.type} #{item.details}"
    end
  end
  def filter(type)
    items_with_filtered_type = @items.select {|item| item.type == type}
    puts "-" * @title.length
    puts make_title(@title)
    puts "-" * @title.length
    puts "Filtered by #{type}s"
    puts "-" * @title.length
    items_with_filtered_type.each_with_index do |item, position|
      puts "#{position + 1}) #{item.type} #{item.details}"
    end
  end  
  def mark_complete(index)
     @completed_items << @items.delete_at(index-1)
  end

end
