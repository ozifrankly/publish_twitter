require 'rails_helper' 
  
RSpec.describe WeatherPublisherService do

  describe "#send_weather_message_from" do
    context "Send success" do
      let (:city_id) {3394023}
      let (:weather_infos) {{
        city: "Natal",
        weathers:[
          {description: "chuva forte", temp: 23.12, time: "2022-07-03 15:00:00"},
          {description: "chuva moderada", temp: 23.2, time: "2022-07-04 00:00:00"},
        ]
      }}
      before do
        @publisher = WeatherTwitter::WeatherPublisher.new
        allow(@publisher).to receive(:send).and_return({:success=>true, :message=>"23.12°C e chuva forte em Natal em 03/07. Média para os próximos dias: 23.2°C em 04/07"})
      end

      it "success is true" do
        service = WeatherPublisherService.new
        allow(service).to receive(:take_infos).and_return(weather_infos)
        allow(service).to receive(:publisher).and_return(@publisher)
        
        result = service.send_weather_message_from(city_id)
        expect(result[:success]).to be_truthy
      end

      it "correct message" do
        service = WeatherPublisherService.new
        allow(service).to receive(:take_infos).and_return(weather_infos)
        allow(service).to receive(:publisher).and_return(@publisher)
        
        result = service.send_weather_message_from(city_id)
        expect(result[:message]).to eq "23.12°C e chuva forte em Natal em 03/07. Média para os próximos dias: 23.2°C em 04/07"
      end
    end
  end


  context "Send success" do
    let (:city_id) {3394023}
    let (:weather_infos) {{
      city: "",
      weathers:[]
    }}
    before do
      @publisher = WeatherTwitter::WeatherPublisher.new
      allow(@publisher).to receive(:send).and_return({:success=>false, :message=>""})
    end

    it "success is true" do
      service = WeatherPublisherService.new
      allow(service).to receive(:take_infos).and_return(weather_infos)
      allow(service).to receive(:publisher).and_return(@publisher)
      
      result = service.send_weather_message_from(city_id)
      expect(result[:success]).to be_falsey
    end

    it "empty message" do
      service = WeatherPublisherService.new
      allow(service).to receive(:take_infos).and_return(weather_infos)
      allow(service).to receive(:publisher).and_return(@publisher)
      
      result = service.send_weather_message_from(city_id)
      expect(result[:message]).to eq ""
    end
  end
end
