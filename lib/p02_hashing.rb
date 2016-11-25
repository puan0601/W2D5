class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_start = 0
    self.each_with_index do |element, i|
      hash_start = (element.hash + i.hash) ^ hash_start
    end

    hash_start
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

# self.chars.map do |element|
#   element.ord.hash
# end.join("").to_i

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
