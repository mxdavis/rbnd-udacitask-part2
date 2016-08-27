class UdaciList
  include UdaciListErrors
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
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

  def delete(index)
    if index <= @items.count
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize
    end 
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
