def self.rate(date, from_currency, to_currency, file_path, base_currency = "EUR")
  # Convert date to string if it's not already a string
  date_str = date.is_a?(String) ? date : date.strftime('%Y-%m-%d')

  file_extension = File.extname(file_path)

  # Load data using the created data source
  data = create_data_source(file_extension, file_path).load_data

  # Check if the date exists in the data
  unless data[date_str]
    raise "Exception Raised: No rate for the date #{date_str}"
  end

  # Extract the rates for the given date
  rates = data[date_str]

  # Check if both currencies exist in the rates
  unless rates[from_currency] && rates[to_currency]
    raise "Exception Raised: Unable to calculate the exchange rate. Rates for #{from_currency} or #{to_currency} not found for the date #{date_str}"
  end

  # Calculate and return the exchange rate
  return rates[to_currency] / rates[from_currency] * (base_currency == to_currency ? 1 : rates[base_currency] / rates[to_currency])
end