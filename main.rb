# frozen_string_literal: true

require './game'

dictionary = File.open('5desk.txt').readlines.map(&:chomp)
secret_word = dictionary.select { |word| word.length.between?(5,12) }.sample
game = Game.new(secret_word)
game.play
