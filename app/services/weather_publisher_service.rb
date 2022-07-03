class WeatherPublisherService

  def send_weather_message_from(city_id)
    weather_infos = take_infos(city_id)
    message = publisher.generate_message(weather_infos)
    publisher.send(message)
  end
  
  private

  def publisher
    @publisher ||= WeatherTwitter::WeatherPublisher.new do |config|
      config.key          = ENV["TWITTER_API_KEY"]
      config.secret       = ENV["TWITTER_API_SECRET"]
      config.token        = ENV["TWITTER_API_TOKEN"]
      config.token_secret = ENV["TWITTER_API_TOKEN_SECRET"]
    end
  end

  def weather_map
    @weather_map ||= WeatherTwitter::WeatherMap.new(ENV["OPEN_WEATHER_MAP_APP_ID"])
  end

  def take_infos(city_id)
    weather_map.take_city_weather(city_id)
  end
end
