require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    a = *("A".."Z")
    @letters = a.sample(10)
  end

  def is_english_word?(url)
    test = URI.open(url).read
    data = JSON.parse(test)
    data[found] == true
  end

  def check_letters_in_grid(letters)
    params[:word].chars.all? { |letter| params[:word].count(letter) <= letters.count(letter) }
  end

  def score
    @letters = params[:letters]
    if check_letters_in_grid(@letters) == false
      @result = { score: 0, message: "you used some letters that are not in the grid"}
    end
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    if is_english_word?(url)
      { message: 'Well done!'}
    else
      { score: 0, message: "not an english word"}
    end
  end

end
