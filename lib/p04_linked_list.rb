require "byebug"

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  # include Enumberable

  def initialize
    @head = Link.new
    @tail = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next.nil? ? @head : @head.next

  end

  def last
    @tail.prev.nil? ? @tail : @tail.prev
  end

  def empty?
    @head.prev.nil? && @tail.prev.nil?
  end

  def get(key)
  end

  def include?(key)
    set_link = @head.next

    until set_link.key == key
      set_link = set_link.next
      return nil if set_link.nil?
    end

    return true if set_link.key == key
    false
  end

  def append(key, val)
    append_link = Link.new(key, val)
    if @tail.prev.nil?
      @tail.prev = append_link
      @head.next = append_link
    else
      @tail.prev.next = append_link
      @tail.prev = append_link
    end
  end

  def update(key, val)
    byebug
    if self.include?(key)
      set_link = @head.next

      until set_link.key == key
        set_link = set_link.next
      end

      set_link.val = val
    end
  end

  def remove(key)
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
