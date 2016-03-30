require 'securerandom'

include GameHelper

class GameController < ApplicationController

	def begin

		words = Word.where(length: params[:length].to_i)
		session[:length] = params[:length].to_i

		depthHash = { 3 => 1, 4 => 1, 5 => 1, 6 => 2, 7 => 2, 8 => 2, 9 => 2, 10 => 2, 11 => 1, 12 => 1, 13 => 1, 14 => 1, 15 => 1}

		state = ""
		params[:length].to_i.times do 
			state += "_"
		end

		session[:state] = state
		session[:game_session_id] = SecureRandom.hex
		filename = "games/" + session[:game_session_id] + ".txt"
		
		File.open(filename, "w+") do |file|
			file.puts("e t a o i n s h r d l u c m f w y p v b g k j q x z\n")
			words.length.times do |word|
				temp_word = words[word].name + "\n"
				file.write(temp_word)
			end
		end
		
		lengthHash = { 3 => 15, 4 => 14, 5 => 13, 6 => 12, 7 => 11, 8 => 10, 9 => 9, 10 => 8, 11 => 7, 12 => 6, 13 => 6, 14 => 6, 15 => 6}
		guessesAllowed = lengthHash[params[:length].to_i]
		session[:guessesAllowed] = guessesAllowed
		session[:guessesRemaining] = guessesAllowed
		rem = 26 % guessesAllowed
		incrementValue = 26 / guessesAllowed

		
		session[:picNumIncrement] = incrementValue
		session[:picNum] = 0
		session[:letterUsed] = ""
		render json: guessesAllowed
	
	end

	def next
		letter = params[:letter]
		validGuess = false

		fileName = "games/" + session[:game_session_id] + ".txt"
		file = File.open(fileName,"r") 
		firstLine = file.gets
		# build left
		left = firstLine.split(" ")
		file.close
		if left.include? letter
			validGuess = true
		end
		returnArray = [ session[:state], session[:guessesRemaining] , false, false ]
		puts returnArray.inspect
		
		if validGuess
			returnArray = minMax_evilHangman(session[:length], session[:depth], letter, session[:state])
			session[:letterUsed] += returnArray[4]
			session[:state] = returnArray[0]
			session[:guessesRemaining] = returnArray[1]			
			if returnArray[3]
				session[:picNum] += session[:picNumIncrement]
				if session[:guessesRemaining] == 0
					session[:picNum] = 25
				end
			end
		end
		
		puts returnArray.inspect

		gameComplete = returnArray[2] || session[:guessesRemaining] == 0
		returnHash = { success: validGuess, state: session[:state], guesses_left: session[:guessesRemaining], won: returnArray[2], picNum: session[:picNum], completed: gameComplete,letterUsed: session[:letterUsed]}
		puts returnHash.inspect
		render json: returnHash

	end

end
