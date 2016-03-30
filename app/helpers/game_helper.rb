module GameHelper
	
	def minMax_evilHangman(length, depth, letter, state)
		# initialize array of words
		words = Array.new
		fileName = "games/" + session[:game_session_id] + ".txt"
		file = File.open(fileName,"r") 
		firstLine = file.gets
		# build left
		left = firstLine.split(" ")
		# build words
		while (line = file.gets)
			words.push(line.chomp!)
		end
		# close the file
		#file.close
		# Boolean representing whether the game is still in progress based on number of guesses
		gameInProgress = true
		# Hash that maps lengths to their associated number of guesses
		lengthHash = { 3 => 15, 4 => 14, 5 => 13, 6 => 12, 7 => 11, 8 => 10, 9 => 9, 10 => 8, 11 => 7, 12 => 6, 13 => 6, 14 => 6, 15 => 6}
		# Hash that maps length to number of words
		wordNumHash = {3 => 962, 4 => 3862, 5 => 8548, 6 => 14383, 7 => 21729, 8 => 26448, 9 => 18844, 10 => 12308, 11 => 7850, 12 => 5194, 13 => 3275, 14 => 1775, 15 => 945}
		# Boolean representing whether the user has won or lost the game
		gameWon = false
		maxDepth = depth
		# remove the user's guess from the remaining letters list
		left.delete(letter)

		emptySlots = 0;
		# initialize the current state
		currentState = Array.new(length)
		length.times do |i| 
			temp = state[i];
			if temp != "_"
				currentState[i] = 1		
			else 
				currentState[i] = 0
				emptySlots += 1
			end
		end	
		numberOfListOfFamilies = 2**emptySlots
		# Initializes an array for storing the families
		# Two copies are created so that the algorithm can store the current word list for future algorithm calls
		listOfFamilies = Array.new(numberOfListOfFamilies)
		copyOfListOfFamilies = Array.new(numberOfListOfFamilies)
		
		# Initializes each family
		numberOfListOfFamilies.times do |i|
				listOfFamilies[i] = Array.new  
				copyOfListOfFamilies[i] = Array.new
		end
		# Categorizes every word by format and adds the words to the appropriate family
		words.length.times do |i|
			wordCheck = Array.new(emptySlots, 0)
			#puts wordCheck
			currentWord = words[i]
			k = 0
			# Changes the word to an array of 1's and 0's for creation of binary number representing the changed letters
			length.times do |j|
				# Is empty character
				if currentState[j] == 0
					if currentWord[j] == letter
						wordCheck[k] = 1
					end
					k += 1
				end
			end

			# Binary string is used to identify the correct family into which the word should be added 
			# (000 means no letters added, 111 means all letters added for 3 empty spaces in a word)
			binary = ""
			emptySlots.times do |m|
				binary += wordCheck[m].to_s
			end
			
			# Converts the binary number into a decimal that is mapped to an index of the arraylist
			indexOfSet = binary.to_i(2) 
			# Adds the word to the appropriate family
			listOfFamilies[indexOfSet].push(currentWord)
			# Creating copy
			copyOfListOfFamilies[indexOfSet].push(currentWord)
		end

		# puts copyOfListOfFamilies.inspect
		
		# call max to generate an array of scores that map to each element of the listOfFamilies
		# Used to find best family
		arrayOfScores = Array.new(numberOfListOfFamilies)
		arrayOfScores.length.times do |i|
			arrayOfScores[i] = max_evilHangman(listOfFamilies[i], left, depth, maxDepth)
		end
			
		# Finds the index of the family with the best score
		maxValue = -1
		maxValueIndex = -1
		arrayOfScores.length.times do |i|
			if arrayOfScores[i] > maxValue
				maxValue = arrayOfScores[i]
				maxValueIndex = i
			end
		end



		# Obtain final return string by taking a random element of the family and converting non-guessed chars to _
		repWord = listOfFamilies[maxValueIndex][0]
		left.length.times do |i|
			leftChar = left[i]
			length.times do |j|
				if leftChar == repWord[j]
					tempCurrentState = repWord[0,j] + "_" + repWord[j+1, length-(j+1)]
					repWord = tempCurrentState
				end
			end
		end


		guessesRemaining = lengthHash[length] - (26 - left.length)
		repWordArray = repWord.split("")

		uniqueChars = repWordArray.uniq.length - 1
		if gameWon
			uniqueChars += 1
		end
		guessesRemaining += uniqueChars
		# Checks if there are any more guesses remaining
		if (guessesRemaining) == 0
			gameInProgress = false
		end
		
		# Checks if the user has won
		if !(repWord.include? "_")
			gameInProgress = false
			gameWon = true
		end

		# puts "Guesses Remaining = #{guessesRemaining}"
		# contains a string with all remaining letters
		remLetters = left.join(" ")
		remLetters += "\n"
		if gameInProgress
			file = File.open(fileName, 'w') { |f|
				f.write(remLetters)
				# Writes all the words in the next set to the session file
				copyOfListOfFamilies[maxValueIndex].length.times do |i|
					tempWord = copyOfListOfFamilies[maxValueIndex][i] + "\n"
					f.write(tempWord)
				end
			}
			#file.close
		else
			statistics(length, lengthHash[length],26 - left.length, wordNumHash[length], copyOfListOfFamilies[maxValueIndex].length, gameWon, repWord)
			File.delete(fileName)
		end

		
		if state == repWord
			advance = true
		else
			advance = false
		end 
		returnValue = [ repWord , guessesRemaining , gameWon , advance, letter]
		
		# returnValue = { success: , state: , guesses_left: , won: gameWon, picNum: }
		# ret
		return returnValue
	end



	def max_evilHangman(family, left, depth, maxDepth)

		# Base Case of final search level or single word remaining in dictionary
		if depth == 1 || family.length == 1
			return family.length
		else 
			# Ensures children exist before expanding
			if !(family.length == 0)
				# map depth to left index
				indexOfLeft =  maxDepth - depth
				# view the letter
				nextGuess = left[indexOfLeft]
				# build the current state
				randomWord = family[0]
				length = randomWord.length
				currentState = ""
				length.times do |j|
					currentState +=  "1"
				end
				# Generates a string containing the binary representative of the elements of the family
				emptySlots = 0
				left.length.times do |i|
					leftChar = left[i]
					length.times do |j|
						if leftChar == randomWord[j]
							tempCurrentState = randomWord[0,j] + "_" + randomWord[j+1, length-(j+1)]
							currentState = tempCurrentState
							emptySlots += 1
						end
					end
				end

				numberOfListOfFamilies = 2**emptySlots
				# Initializes an array for storing the families
				listOfFamilies = Array.new(numberOfListOfFamilies)
				
				# Initializes each family
				numberOfListOfFamilies.times do |i|
						listOfFamilies[i] = Array.new  			        
				end

				family.length.times do |i|
					wordCheck = Array.new(emptySlots, 0)
					currentWord = family[i]
					k = 0
					# Changes the word to an array of 1's and 0's for creation of binary number representing the changed letters
					length.times do |j|
						# Is empty character
						if currentState[j] == 0
							if currentWord[j] == nextGuess
								wordCheck[k] = 1
							end
							k += 1
						end
					end
					# Binary string is used to identify the correct family into which the word should be added 
					# (000 means no letters added, 111 means all letters added for 3 empty spaces in a word)
					binary = ""
					emptySlots.times do |m|
						binary += wordCheck[m].to_s
					end
					# Converts the binary number into a decimal that is mapped to an index of the arraylist
					indexOfSet = binary.to_i(2) 
					# Adds the word to the appropriate family
					listOfFamilies[indexOfSet].push(currentWord)
				end
				# puts listOfFamilies.inspect
				# call min to generate an array of scores that map to each element of the listOfFamilies
				arrayOfScores = Array.new(numberOfListOfFamilies)
				arrayOfScores.length.times do |i|
					arrayOfScores[i] = min_evilHangman(listOfFamilies[i], left, depth-1, maxDepth)
				end
					
				# Finds the index of the family with the best score
				maxScore = 0
				arrayOfScores.length.times do |i|
					if arrayOfScores[i] > maxScore
						maxScore = arrayOfScores[i]
					end
				end
				return maxScore
			else 
				return 0    
			end
		end
	end

	def min_evilHangman(family, left, depth, maxDepth)

		# Base Case of final search level or single word remaining in dictionary
		if depth == 1 || family.length == 1
			return family.length
		else 
			# Ensures children exist before expanding
			if !(family.length == 0)
				# map depth to left index
				indexOfLeft =  maxDepth - depth
				# view the letter
				nextGuess = left[indexOfLeft]
				# build the current state
				randomWord = family[0]
				length = randomWord.length
				currentState = ""
				length.times do |j|
					currentState +=  "1"
				end
				# Generates a string containing the binary representative of the elements of the family
				emptySlots = 0
				left.length.times do |i|
					leftChar = left[i]
					length.times do |j|
						if leftChar == randomWord[j]
							tempCurrentState = randomWord[0,j] + "_" + randomWord[j+1, length-(j+1)]
							currentState = tempCurrentState
							emptySlots += 1
						end
					end
				end

				numberOfListOfFamilies = 2**emptySlots
				# Initializes an array for storing the families
				listOfFamilies = Array.new(numberOfListOfFamilies)
				
				# Initializes each family
				numberOfListOfFamilies.times do |i|
						listOfFamilies[i] = Array.new  			        
				end

				family.length.times do |i|
					wordCheck = Array.new(emptySlots, 0)
					currentWord = family[i]
					k = 0
					# Changes the word to an array of 1's and 0's for creation of binary number representing the changed letters
					length.times do |j|
						# Is empty character
						if currentState[j] == 0
							if currentWord[j] == nextGuess
								wordCheck[k] = 1
							end
							k += 1
						end
					end
					# Binary string is used to identify the correct family into which the word should be added 
					# (000 means no letters added, 111 means all letters added for 3 empty spaces in a word)
					binary = ""
					emptySlots.times do |m|
						binary += wordCheck[m].to_s
					end
					# Converts the binary number into a decimal that is mapped to an index of the arraylist
					indexOfSet = binary.to_i(2) 
					# Adds the word to the appropriate family
					listOfFamilies[indexOfSet].push(currentWord)
				end
				# puts listOfFamilies.inspect
				# call min to generate an array of scores that map to each element of the listOfFamilies
				arrayOfScores = Array.new(numberOfListOfFamilies)
				arrayOfScores.length.times do |i|
					arrayOfScores[i] = min_evilHangman(listOfFamilies[i], left, depth-1, maxDepth)
				end
					
				# Finds the index of the family with the best score
				minScore = 2000000000
				arrayOfScores.length.times do |i|
					if arrayOfScores[i] < minScore
						minScore = arrayOfScores[i]
					end
				end
				return minScore
			else 
				return 0    
			end
		end
	end

	def statistics(length, guessesAllowed, guessesUsed, initialWordNumber, wordsRemaining, gameWon, finalState)
		s = Stat.new
		s.user_id = session[:user_id]
		s.word_length = length
		s.number_guesses_allowed = guessesAllowed
		s.number_guesses = guessesUsed
		s.number_initial_words = initialWordNumber
		s.number_words_left = wordsRemaining
		s.won = gameWon
		s.final_state = finalState
		s.save
	end
end
