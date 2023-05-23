# require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    array_of_letter = ('A'..'Z').to_a
    @letters = array_of_letter.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(" ")
    splitted_word = @word.upcase.split('')
    @result = splitted_word.all? { |letter| @letters.include?(letter) }
    @exist = find_word(@word)
    @score = @word.size * @word.size
  end

  private

  def find_word(word)
    @response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    @repos = JSON.parse(@response)
    @word_founded = @repos['found']
  end
end



# Le mot ne peut pas être créé à partir de la grille d’origine.
# Le mot est valide d’après la grille, mais ce n’est pas un mot anglais valide.
# Le mot est valide d’après la grille et est un mot anglais valide.
