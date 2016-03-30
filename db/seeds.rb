# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Stat.delete_all
User.delete_all
Word.delete_all

User.create(:name => "Brutus", :email => "brutus@osu.edu", :password => "password", :password_confirmation => "password")
User.create(:name => "Biff", :email => "biff@umich.edu", :password => "password", :password_confirmation => "password")

Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 9, :number_initial_words => 12000, :number_words_left => 0, :final_state => "money")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 7, :number_initial_words => 12000, :number_words_left => 0, :final_state => "abyss")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1200, :final_state => "m__ey")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1000, :final_state => "scu__")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 9, :number_initial_words => 12000, :number_words_left => 0, :final_state => "money")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 7, :number_initial_words => 12000, :number_words_left => 0, :final_state => "abyss")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1200, :final_state => "m__ey")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1000, :final_state => "scu__")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 9, :number_initial_words => 12000, :number_words_left => 0, :final_state => "money")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 7, :number_initial_words => 12000, :number_words_left => 0, :final_state => "abyss")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1200, :final_state => "m__ey")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1000, :final_state => "scu__")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 9, :number_initial_words => 12000, :number_words_left => 0, :final_state => "money")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 7, :number_initial_words => 12000, :number_words_left => 0, :final_state => "abyss")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1200, :final_state => "m__ey")
Stat.create(:user_id => 1, :won => false, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1000, :final_state => "scu__")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 9, :number_initial_words => 12000, :number_words_left => 0, :final_state => "money")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 7, :number_initial_words => 12000, :number_words_left => 0, :final_state => "abyss")
Stat.create(:user_id => 1, :won => false, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1200, :final_state => "m__ey")
Stat.create(:user_id => 1, :won => false, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1000, :final_state => "scu__")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 9, :number_initial_words => 12000, :number_words_left => 0, :final_state => "money")
Stat.create(:user_id => 1, :won => true, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 7, :number_initial_words => 12000, :number_words_left => 0, :final_state => "abyss")
Stat.create(:user_id => 1, :won => false, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1200, :final_state => "m__ey")
Stat.create(:user_id => 1, :won => false, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1000, :final_state => "scu__")
Stat.create(:user_id => 2, :won => false, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 132, :final_state => "di__y")
Stat.create(:user_id => 2, :won => false, :word_length => 3, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 0, :final_state => "_a_")
Stat.create(:user_id => 2, :won => false, :word_length => 15, :number_guesses_allowed => 10, :number_guesses => 10, :number_initial_words => 12000, :number_words_left => 2131, :final_state => "__________a_r__")
Stat.create(:user_id => 2, :won => false, :word_length => 8, :number_guesses_allowed => 11, :number_guesses => 11, :number_initial_words => 12000, :number_words_left => 1200, :final_state => "m__ey___")
Stat.create(:user_id => 2, :won => false, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 1000, :final_state => "scu__")
Stat.create(:user_id => 2, :won => false, :word_length => 5, :number_guesses_allowed => 12, :number_guesses => 12, :number_initial_words => 12000, :number_words_left => 23, :final_state => "d_zzy")

puts "loading dictionary3"
File.open("dictionaries/dictionary3.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 3)
	end
end

puts "loading dictionary4"
File.open("dictionaries/dictionary4.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 4)
	end
end

puts "loading dictionary5"
File.open("dictionaries/dictionary5.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 5)
	end
end

puts "loading dictionary6"
File.open("dictionaries/dictionary6.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 6)
	end
end

puts "loading dictionary7"
File.open("dictionaries/dictionary7.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 7)
	end
end

puts "loading dictionary8"
File.open("dictionaries/dictionary8.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 8)
	end
end

puts "loading dictionary9"
File.open("dictionaries/dictionary9.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 9)
	end
end

puts "loading dictionary10"
File.open("dictionaries/dictionary10.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 10)
	end
end

puts "loading dictionary11"
File.open("dictionaries/dictionary11.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 11)
	end
end

puts "loading dictionary12"
File.open("dictionaries/dictionary12.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 12)
	end
end

puts "loading dictionary13"
File.open("dictionaries/dictionary13.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 13)
	end
end

puts "loading dictionary14"
File.open("dictionaries/dictionary14.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 14)
	end
end

puts "loading dictionary15"
File.open("dictionaries/dictionary15.txt", "r") do |file_handle|
	file_handle.each_line do |line|
		Word.create(:name => line.chop, :length => 15)
	end
end

