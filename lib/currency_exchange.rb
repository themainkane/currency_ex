require 'json_data_source'
require 'data_source'

module CurrencyExchange

  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  require 'json'


 def self.rate(date, from_currency, to_currency, file_path) #add file path and base currency here
  
  date_str = date.is_a?(String) ? date : date.strftime('%Y-%m-%d')

  file_extension = File.extname(file_path)
    # Create an instance of the appropriate data source class based on the file extension
    source = create_data_source(file_extension, file_path)

    # Load data using the created data source
    data = source.load_data

    # Check if the date exists in the data
    unless data[date_str]
      raise "Exception Raised: No rate for the date #{date}"
    end

    # Extract the rates for the given date
    rates = data[date_str]

    # Check if both currencies exist in the rates
    unless rates[from_currency] && rates[to_currency]
      raise "Exception Raised: Unable to calculate the exchange rate"
    end

    # Calculate and return the exchange rate
    return rates[to_currency] / rates[from_currency]
 end
  private

  def self.create_data_source(file_extension, file_path)
    case file_extension
    when '.json'
      JsonDataSource.new(file_path)
    # Add more cases for other data source types if needed
    else
      raise "Unsupported file type"
    end
  end
end



