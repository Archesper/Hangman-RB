# frozen_string_literal: true

require 'yaml'
require './display'
require './serialization'
require './helper'
# Game class
class Game
  attr_accessor :secret_word, :correct_guessed_letters, :wrong_guessed_letters

  include Display
  include Serialization

  def initialize(secret_word)
    @save_dir = 'Saved Games'
    @secret_word = secret_word
    @correct_letters = @secret_word.split('').map(&:downcase)
    @guess_count = 0
    @correct_guessed_letters = []
    @wrong_guessed_letters = []
  end

  def play
    puts display_word_length
    until game_over? || game_solved?
      print_turn_info
      guess = player_guess
      if guess == 'save'
        save_name_input
        return nil
      end
      update_guessed_letters(guess)
    end
    puts @guess_count == 10 ? failure_message : victory_message
  end

  private

  def player_guess
    guess = gets.chomp.downcase
    until (guess.is_alpha? && not_guessed?(guess)) || guess == 'save'
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

  def save_name_input
    puts save_game_message
    filename = gets.chomp
    make_savedir
    while game_exists?(filename)
      puts game_already_exists
      filename = gets.chomp
    end
    save_game(filename)
    puts game_saved_successfully
  end
end
