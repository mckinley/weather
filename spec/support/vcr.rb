VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.ignore_localhost = true
  c.filter_sensitive_data('<OPEN_WEATHER_API_KEY>') { Services::OpenWeatherService::OPEN_WEATHER_API_KEY }
  c.filter_sensitive_data('<NOAA_API_CONTACT_WEBSITE>') { Services::NoaaService::NOAA_API_CONTACT_WEBSITE }
  c.filter_sensitive_data('<NOAA_API_CONTACT_EMAIL>') { Services::NoaaService::NOAA_API_CONTACT_EMAIL }
end
