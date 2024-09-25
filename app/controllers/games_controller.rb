require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ("A".."Z").to_a[rand(26)] }
  end
  def score
    if params[:word].chars.all? { |letter| params[:word].count(letter) <= params[:letters].count(letter) }
      response = URI.parse("https://dictionary.lewagon.com/#{params[:word]}")
      if JSON.parse(response.read)["found"]
        @result = "Congratulations! Your word #{params[:word]} is correct!"
      else
        @result = "Sorry, but #{params[:word]} is not an English word."
      end
    else
      @result = "Sorry, but #{params[:word]} can't be built out of #{params[:letters]}."
    end
  end
end
