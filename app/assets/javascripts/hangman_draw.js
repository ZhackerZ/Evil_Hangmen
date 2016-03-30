
// Limit must be between 1 an 26 inclusive.
function HangmanDraw(dom, limit) {

	// Initialize instance variables.
	this.dom = dom;	

}

HangmanDraw.prototype = {

	draw: function(picNum) {

		// Change the background picture of this.dom.
		var indexString = ("00" + picNum).slice(-2);
		this.dom.css('backgroundImage', "url(/assets/hangman-pics/hangman-" + indexString + ".png)");

	}

}
