class PublishController < ApplicationController

  def weather
    service = WeatherPublisherService.new
    render json: service.send_weather_message_from(params[:city_id])
  end
end
