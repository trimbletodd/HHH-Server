puts "In mongo.rb initializer in #{Rails.env}"
yaml_config = YAML.load_file("config/mongo.yml")[Rails.env]

puts yaml_config

MongoMapper.connection = Mongo::Connection.new(yaml_config["host"], yaml_config["port"])
MongoMapper.database = yaml_config["database"]
# MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
# MongoMapper.database = "hhh_#{Rails.env}"

puts "Loading MongoDB #{MongoMapper.database} (#{yaml_config["database"]}) via MongoMapper"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end
