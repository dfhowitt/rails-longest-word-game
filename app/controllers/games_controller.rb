require 'open-uri'
class GamesController < ApplicationController
  def new
    #save time as instance variable & pass through the form
    @array = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << @array.sample }
  end

  def score
    @end_time = Time.now.to_time.to_i
    @time = @end_time - params[:start_time].to_i
    @answer = params[:answer]
    @answer_letters = @answer.downcase.chars
    @length = @answer_letters.length
    @letters = params[:sample].downcase.chars
    response = open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    @json = JSON.parse(response.read)
    if @answer_letters.all? do |letter|
      @answer_letters.count(letter) <= @letters.count(letter)
    end
      if @json['found'] == true
        @message = "Congratulations! #{@answer} gets you a score of #{(@answer.length*10)/@time}. Great answer"
      else
        @message = 'Your answer is not a word!'
     end
   else
     @message = 'Your answer uses letters from outside the grid!'
    end
  end
end
