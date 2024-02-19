require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = generate_letters(10)
  end

  def score
    @longestsword = params[:longestsword]
    @letters = params[:letters]

    url = "https://wagon-dictionary.herokuapp.com/#{@longestsword}"
    response = URI.open(url)
    data = JSON.parse(response.read)

    lettersArray = @longestsword.split("")
    # result = lettersArray - @letters


    result = lettersArray.all? { |e| @letters.include?(e) }

    if result
      if data["found"]
        @score = "Congratulations! #{@longestsword} is a valid English word"
      else
        @score = "Sorry but #{@longestsword} does not seem to be a valid English word"
      end
    else
      @score = "Sorry but #{@longestsword} can't be built out of #{@letters}"
    end
  end

  private

  def generate_letters(count)
    (0...count).map { (65 + rand(26)).chr }
  end
end
