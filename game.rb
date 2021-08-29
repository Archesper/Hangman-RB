# frozen_string_literal: true

require './display'
require './helper'
# Game class
class Game
  attr_accessor :secret_word, :correct_guessed_letters, :wrong_guessed_letters

  include Display

  def initialize(secret_word)
    @secret_word = secret_word
    @correct_letters = @secret_word.split('').map(&:downcase)
    @guess_count = 0
    @correct_guessed_letters = []
    @wrong_guessed_letters = []
  end

  def play
    puts display_word_length
    until game_over? || game_solved?
      puts display_word
      puts previous_guesses unless @wrong_guessed_letters.empty?
      puts incorrect_guesses_left
      guess = player_guess
      update_guessed_letters(guess)
    end
    puts @guess_count == 10 ? failure_message : victory_message
  end

  private

  def player_guess
    guess = gets.chomp.downcase
    until guess.is_alpha? && not_guessed?(guess)
      puts guess.is_alpha? ? already_guessed(guess) : invalid_input_message
      guess = gets.chomp.downcase
    end
    guess
  end

  def update_guessed_letters(guess)
    if @correct_letters.include?(guess)
      puts correct_guess_message(guess)
      @correct_guessed_letters.push(guess)
    else
      puts wrong_guess_message(guess)
      @guess_count += 1
      @wrong_guessed_letters.push(guess)
    end
  end

  def not_guessed?(guess)
    !(@wrong_guessed_letters + @correct_guessed_letters).include?(guess)
  end

  def game_over?
    @guess_count == 10
  end

  def game_solved?
    (@correct_letters - @correct_guessed_letters).empty?
  end
end
