#!/usr/bin/env ruby
require "pry"

def create_dictionary
dictionary = Hash.new(0)
 file = File.readlines('words.txt')
  file.each do |line|
   word_split = line.downcase.split(/[^\b(\w+)\b]/)
   word_split.each do |word|
     dictionary[word] += 1
   end
  end
  dictionary
end

def sorted
  Hash[create_dictionary.sort_by {|word, count| count}.reverse]
end

def check_words(input)
 words = input.downcase.split(/[^\b(\w+)\b]/)
 words.each do |word|
  #call new method that iterates through the dropped letter version of the word
  check_deleted_letters(word)
  end
 end

 def dictionary_check(temp_word)
   correct_sentence = []
   if sorted[temp_word]
     correct_sentence << temp_word
   end
   puts correct_sentence
 end


def check_deleted_letters(word)
  characters = word.split('')
  characters.each_with_index do |chr, index|
    temp_character = characters.delete_at(index)
    temp_word = characters.join
    dictionary_check(temp_word)
    #insert method to check against dictionary
    characters.insert(index, temp_character)
  end







  # char = word.split('')
  # array = [word]
  #
  #
  # 0.upto(word.length) do |i|
  #   char.delete_at (char[i])
  #   binding.pry
  # end

 #  char.each_with_index do |chr, index|
 #    char = char.slice(0, word.length-1)
 #    print char
 #    if sorted.include? char
 #      binding.pry
 #      return char
 #    else
 #      word
 #    end
 # end
end










def correct(sentence)
  # YOUR CODE HERE
end

# input = ARGV.join(" ")
input = "copeyright larws faor yodur coundtry"
create_dictionary
check_words(input)
