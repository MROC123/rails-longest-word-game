class GamesController < ApplicationController
  def new
    @letters = 10.times.map { [*'A'..'Z'].sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @reply = 'congratulations'

    @word.upcase.chars.each do |char|
      if @letters.include?(char)
        @letters.delete(char)
      else
        @reply = "#{@word.upcase} can't be built"
        break
      end
    end

    if @reply == 'congratulations'
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
      data = JSON.parse(response)
        if data["found"]
          @reply = "great, #{@word.upcase} is in the dictionary"
        else
          @reply = "#{@word.upcase} not in the dictionary"
        end
    end
  end
end
