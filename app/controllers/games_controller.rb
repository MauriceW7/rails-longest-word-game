require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @start = Time.now
    @word = params[:word]
    @finish = Time.now
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)
    if json['found'] && json['word'].include?('@letters')
      @points = json['length']**2
      @message = "Well done!"
    elsif json['found'] && !json['word'].include?('@letters')
      @message = "Word exits but not made up of grid, 0 points"
    # elsif json['word'].include?("@letters") && !json['found']
    else
      @message = "Word made up of grid but doesn't exist, 0 points"
    end
  end
end
