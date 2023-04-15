class CustomHash < Hash
  def initialize(hash = {})
    hash.each do |key, value|
      self[key] = value
    end
  end
end
