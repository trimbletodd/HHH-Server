class Location
  include MongoMapper::EmbeddedDocument

  key :latitude, String
  key :longitude, String

  validates_numericality_of :latitude, :less_than_or_equal_to => 90, :greater_than_or_equal_to => -90
  validates_numericality_of :longitude, :less_than_or_equal_to => 180, :greater_than_or_equal_to => -180
  
  # Location Object incoming
  def self.to_mongo(loc)
    unless loc.nil?
      {:latitude => loc[:latitude], :longitude => loc[:longitude]}
    end
  end

  # Hash incoming
  def self.from_mongo(loc)
    unless loc.nil?
      l = Location.new :latitude => loc[:latitude], :longitude => loc[:longitude]
    end
  end   
end
