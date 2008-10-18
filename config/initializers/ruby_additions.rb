class String
  def self.random_string(length = 8, chars = nil)
    chars ||= ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    Array.new(length) { chars[rand(chars.size)] }.join
  end
end
