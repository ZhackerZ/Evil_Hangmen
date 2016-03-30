// Case insensitivity.

var gameAlg, gameDom, lettersDom, messageDom, guessDom, 
guessesLeftDom, gameBoardDom, lettersUsedDom;


$(document).ready(function() {
	gameDom = $('#game');
	load_length_screen();
})


function load_length_screen() {

	// Clear the game dom.
	gameDom.html('');

	// Create the necessary dom elements.
	var title     = $('<h1></h1>').text('Welcome to Evil Hangman').attr('id', 'title');
	var subtitle  = $('<h2></h2>').text('Choose a word length').attr('id', 'subtitle');
	var lengthDom = $('<div></div>').attr('id', 'lengthInput');
	var buttons   = $('<div></div>');

	// Allowed Word Lengths.
	var allowed_word_lengths = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

	// Define the button click event handler.
	handler = function() {

		var length = $(this).text();
		
		// Validate input.
		if ($.isNumeric(length)) {

			// Send GET request for dictionary. 
			
			$.ajax({
				url: '/game/begin?length=' + length
			}).done(function(guesses_allowed) {
				load_play_screen(length, guesses_allowed);
			})
		}

	};

	for (var i = 0; i < allowed_word_lengths.length; i++) {
		var button = $('<button></button>').text(allowed_word_lengths[i]).addClass('word_length_button');
		button.click(handler);
		lengthDom.append(button);
	}

	// Append elements to game dom.
	gameDom.append(title, subtitle, lengthDom);


	//button.click(); // Delete later.
}

function load_play_screen(length, guesses_allowed) {

	// Clear the game dom.
	gameDom.html('');

	// Initialize the guesses left.
	var new_guesses_left = guesses_allowed;

	// Initialize the hangman drawing.
	hangmanDom = $('<div></div>').attr('id', 'hangman');
	hangman = new HangmanDraw(hangmanDom);
	hangman.draw(0);

	// Create the necessary dom elements.
	for (var letters = ''; letters.length < length; letters += '_');
	lettersDom     = $('<div></div>').text(letters).attr('id', 'letters');
	messageDom     = $('<div></div>').text('Please enter a guess').attr('id', 'message');
	guessDom       = $('<div></div>');
	guessesLeftDom = $('<div></div>').text("You have " + new_guesses_left + " guesses left.")
	gameBoardDom   = $('<div></div>').attr('id', 'gameBoard');
	lettersUsedDom = $('<div></div>').attr('id', 'lettersUsed');
	var input      = $('<input>').attr({'type': 'text', 'id':'guessInput'});
	var button     = $('<button></button>').text('Submit Guess');
	
	// Add button event listener.
	button.click(function() {

		var guess = input.val();

		// Validate input.
		if (guess.length === 1) {

			// Apply Guess.
			apply_guess(guess);
			input.val('');

		}

		input.focus();

	})

	// Add listener for enter event.
	input.keydown(function(e) {
		if (e.which == 13) {
			button.click();
		}
	})

	// Append elements to game dom.
	guessDom.append(input, button);
	gameBoardDom.append(lettersDom, messageDom, guessDom, guessesLeftDom, lettersUsedDom = $('<div></div>').attr('id', 'lettersUsed'));
	gameDom.append(gameBoardDom, hangmanDom);

	input.focus();

}

function apply_guess(guess) {

	var new_message;
	var new_state;

	$.ajax({
		
		url: '/game/next?letter=' + guess

	}).done(function(statusHash) {

		console.log(statusHash);

		// Reset the message text.
		messageDom.text('Please enter a guess');

		// React based on statusHash values.
		var success     = statusHash['success'];
		var state       = statusHash['state'];
		var guessesLeft = statusHash['guesses_left'];
		var completed   = statusHash['completed'];
		var won         = statusHash['won'];
		var picNum      = statusHash['picNum'];
		var lettersUsed = statusHash['letterUsed'];

		if (!success) {
			// Letter was already played.
			new_message = "Letter was already played!";

		} else {

			// Update state, hangman, guesses left.
			new_state = state;
			hangman.draw(picNum);
			new_guesses_left = guessesLeft;

		}

		if (completed) {
			if (won) {
				new_message = "You won!!";
				messageDom.addClass("won");
			} else {
				new_message = "You lost!!";
				messageDom.addClass("lost");
			}

			messageDom.addClass("completed");

			// Remove the guess box from the game display.
			guessDom.remove();

			// Add play again.
			var playAgain = $('<button></button>').text('Play Again');
			playAgain.click(load_length_screen);
			gameBoardDom.append(playAgain);

		}

		messageDom.text(new_message);
		lettersDom.text(new_state);
		guessesLeftDom.text("You have " + new_guesses_left + " guesses left.");
		lettersUsedDom.text(lettersUsed);

	})

}




