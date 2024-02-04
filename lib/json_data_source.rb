require 'data_source'

class JsonDataSource
  include DataSource

  #when class created 
  def initialize(file_path)
    @file_path = File.expand_path(file_path, __dir__)
  end

  def load_data
    puts "Loading data from #{@file_path}"
    json = File.read(@file_path)
    parsed_data = JSON.parse(json)
    # puts "Parsed data: #{parsed_data}"
    parsed_data
  end
end