require_relative 'p02_hashing'
require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if num_buckets - 1 == count
    unless self.include?(key)
      self[key.hash] << key
      @count += 1
      return key
    end
    nil
  end

  def remove(key)
    if self.include?(key)
      self[key.hash].map { |value| self[key.hash].delete(key) }
      @count -= 1
    else
      raise "Object not in set!"
    end
  end

  def include?(key)
    self[key.hash].each do |value|
      return true if value == key
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
