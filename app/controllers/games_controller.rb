require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @splitted_words = @word.split("")
    @letters = params[:letters]
    @splitted_letters = @letters.split(" ")

    @english_url = "https://dictionary.lewagon.com/#{@word}"
    english_word = URI.open(@english_url).read
    @data = JSON.parse(english_word)

    if @splitted_words.all? { |letter| @splitted_words.count(letter) <= @splitted_letters.count(letter) }
      if @data["found"] == true
        @response = 'Congrats'
      else
        @response = "Sorry, it's not an english word"
      end
    else
      @response = "Sorry but #{@word} can't be built out of #{@letters}"
    end
  end
end
