# frozen_string_literal: true

require './display'
require './helper'
# Game class
class Game
  attr_accessor :secret_word, :correct_guessed_letters, :wrong_guessed_letters

  include Display

  def initialize(secret_word)
    @secret_word = secret_word
    @guess_count = 0
    @correct_guessed_letters = []
    @wrong_guessed_letters = []
  end

  def play
    correct_letters = @secret_word.split('').map(&:downcase)
    puts display_word_length
    until @guess_count == 10 || (correct_letters - @correct_guessed_letters).empty?
      puts display_word
      puts previous_guesses unless @wrong_guessed_letters.empty?
      puts incorrect_guesses_left
      guess = gets.chomp.downcase
      until guess.is_alpha? && !(@wrong_guessed_letters + @correct_guessed_letters).include?(guess)
        puts guess.is_alpha? ? already_guessed(guess) : invalid_input_message
        guess = gets.chomp.downcase
      end
      if correct_letters.include?(guess)
        puts correct_guess_message(guess)
        @correct_guessed_letters.push(guess)
      else
        puts wrong_guess_message(guess)
        @guess_count += 1
        @wrong_guessed_letters.push(guess)
      end
    end
    puts @guess_count == 10 ? failure_message : victory_message
  end
end
