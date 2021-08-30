# frozen_string_literal: true

# Methods for serializing game class / saving games
module Serialization
  SAVE_DIR = 'Saved Games'
  def to_yaml
    YAML.dump({
                secret_word: @secret_word,
                guess_count: @guess_count,
                correct_letters: @correct_letters,
                correct_guessed_letters: @correct_guessed_letters,
                wrong_guessed_letters: @wrong_guessed_letters
              })
  end

  def save_game(filename)
    File.open("#{SAVE_DIR}/#{filename}.yaml", 'w') { |file| file.print to_yaml }
  end

  def make_savedir
    Dir.mkdir(SAVE_DIR) unless File.exist? SAVE_DIR
  end

  def game_exists?(filename)
    File.exist? "#{SAVE_DIR}/#{filename}.yaml"
  end
end
