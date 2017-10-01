class WeathersController < ApplicationController
  def index 
    if params[:city] && params[:state]
      city = params[:city]
      state = params[:state]
    else
      city = "sanfrancisco"
      state = "ca"
    end

    @weather = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{city}%2C%20#{state}k%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body

    @current_temp = @weather['query']['results']['channel']['item']['condition']['temp']


    @location = @weather['query']['results']['channel']['location']

    @forecast = @weather['query']['results']['channel']['item']['forecast']

     @city_name = @weather['query']['results']['channel']['location']['city']

  end
end
