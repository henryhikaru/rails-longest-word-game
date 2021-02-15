require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @given = params[:letters].split
  	if (params[:word].upcase.split("") - @given).empty?
      if english_word?(params[:word])
        @response = "good"
      else
        @response = "not a word"
      end
    else
      @response = "not in array"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end


