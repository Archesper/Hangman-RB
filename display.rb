# frozen_string_literal: true

# Methods for displaying game information
module Display
  def display_word
    letters = @secret_word.split('')
    letters.map! do |letter|
      letter = @correct_guessed_letters.include?(letter.downcase) ? letter : '_'
    end
    "\e[96;1m#{letters.join(' ')}\e[m"
  end

  def display_word_length
    "\e[1;34mThe secret word has been generated! It's #{@secret_word.length} letters long.\e[m"
  end

  def incorrect_guesses_left
    if 10 - @guess_count > 1
      "\e[93mYou have #{10 - @guess_count} guesses left!\e[m"
    else
      "\e[1;91mYou have one guess left!\e[m"
    end
  end

  def previous_guesses
    "Wrong letters you have previously guessed: \e[31m#{@wrong_guessed_letters}\e[0m"
  end

  def already_guessed(guess)
    "\e[91mYou've already guessed #{guess}!\e[m"
  end

  def invalid_input_message
    "\e[33mPlease input a valid letter.\e[m"
  end

  def correct_guess_message(guess)
    "\e[32mLetter #{guess} was a correct guess!\e[m"
  end

  def wrong_guess_message(guess)
    "\e[31mLetter #{guess} was an incorrect guess.\e[m"
  end

  def failure_message
    "Game over! The word you were trying to guess was \"\e[4m#{@secret_word}\e[m\""
  end

  def victory_message
    "\e[32;1mYou guessed the word: \e[4m#{@secret_word}\e[m\e[m"
  end
end
