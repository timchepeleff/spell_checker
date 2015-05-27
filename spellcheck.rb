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
  revised_sentence = []
  words.each do |word|
    revised_sentence << check_many(word)
  end
  revised_sentence.join(" ")
end

def dictionary_check(temp_word)
  sorted[temp_word]
end

def check_many(word)
  ck1 = check_frequency(check_deleted_letters(word))
  ck2 = check_frequency(check_letter_missing(word))
  ck3 = check_frequency(check_swapped_letter(word))

  trueword = [ck1, ck2, ck3]

  most_frequent_word = trueword.sort_by {|pair| pair.values}.reverse
  return most_frequent_word[0].keys[0]
end


def check_frequency(word)
  if sorted[word] == nil
    { word => 0 }
  else
    { word => sorted[word]}
  end
end

def check_letter_missing(word)
  characters = word.split('')
  characters.each_with_index do |chr, index|
    characters.insert(index, ".")
    temp_word = /(#{characters.join})/
      sorted.each do |sorted_word, count|
        if temp_word.match(sorted_word)
          return sorted_word
        end
      end
    characters.delete_at(index)
  end
  word
end

def check_swapped_letter(word)
  characters = word.split('')
  count = 0
  characters.each_with_index do |chr, index|
    temp_character = characters.delete_at(index)

    characters.insert(index + 1, temp_character)
    temp_word = characters.join
    count += 1
    if dictionary_check(temp_word)
      return temp_word
    elsif count == word.length - 1
      return word
    end

    characters.delete_at(index + 1)
    characters.insert(index, temp_character)
  end
 word
end

def check_deleted_letters(word)
  characters = word.split('')
  characters.each_with_index do |chr, index|
    temp_character = characters.delete_at(index)
    temp_word = characters.join

    return temp_word if dictionary_check(temp_word)

    characters.insert(index, temp_character)
  end
  word
end

def correct(sentence)
  # YOUR CODE HERE
end

# input = ARGV.join(" ")
input = "i spel reallly good"
create_dictionary
result = check_words(input)
puts result
