require 'rails_helper'

RSpec.describe "Publishes", type: :request do
  describe "POST /publish_weather" do
    context "found city" do 
      before do
        allow_any_instance_of(WeatherPublisherService).to receive(:send_weather_message_from).and_return({
          "success": true,
          "message": "22.36°C e chuva forte em Natal em 04/07. Média para os próximos dias: 23.13°C em 05/07, 24.02°C em 06/07, 23.56°C em 07/07, 24.28°C em 08/07"
        })
      end

      it "correct's message" do
        post "/publish_weather", params: {city_id: 3394023}
        result = JSON.parse(response.body)

        expect(result["success"]).to be_truthy
        expect(result["message"]).to eq "22.36°C e chuva forte em Natal em 04/07. Média para os próximos dias: 23.13°C em 05/07, 24.02°C em 06/07, 23.56°C em 07/07, 24.28°C em 08/07"
      end
    end

    context "not found city" do 
      before do
        allow_any_instance_of(WeatherPublisherService).to receive(:send_weather_message_from).and_return({
          "success": false,
          "message": ""
        })
      end

      it "no message" do
        post "/publish_weather", params: {city_id: 222223394023}
        result = JSON.parse(response.body)

        expect(result["success"]).to be_falsey
        expect(result["message"]).to eq ""
      end
    end
  end
end
