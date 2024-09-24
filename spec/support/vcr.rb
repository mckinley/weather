VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.ignore_localhost = true
  c.filter_sensitive_data('<OPEN_WEATHER_API_KEY>') { ENV['OPEN_WEATHER_API_KEY'] }
end
