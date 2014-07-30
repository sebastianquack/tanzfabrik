class Time
  def round_to_fifteen()
    return Time.at((self.to_i / 900).round * 900)
  end
  def round_to_twenty()
    return Time.at((self.to_i / 1200).round * 1200)
  end
end