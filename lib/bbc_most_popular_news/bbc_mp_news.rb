class BbcMpNews
  attr_accessor :rank,:headline,:link, :details

  @@all = []

  def initialize(news_hash)
    news_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(news_array)
    news_array.each { |news_hash| self.new(news_hash) }
  end

  def add_details_attribute(news_details)
    self.details = news_details
  end

  def self.all
    @@all
  end

end
