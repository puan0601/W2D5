require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
    raise "Out of bounds" if num > @max - 1 || num < 0
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self.include?(num)
  end

  def remove(num)
    self[num].map { |number| self[num].delete(number) }
  end

  def include?(num)
    self[num].each do |number|
      return true if number == num
    end
    false
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 3)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets - 1 == count
    unless self.include?(num)
      self[num] << num
      @count += 1
      return num
    end
    nil
  end

  def remove(num)
    if self.include?(num)
      self[num].map { |number| self[num].delete(number) }
      @count -= 1
    else
      raise "Number not in set!"
    end
  end

  def include?(num)
    self[num].each do |number|
      return true if number == num
    end
    false
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }

    old_store.flatten.each do |number|
      insert(number)
    end
  end
end
