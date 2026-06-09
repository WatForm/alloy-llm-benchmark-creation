// from: https://github.com/elkel53930/software_abstructions/blob/master/ch04/4.8/ThreeOfAKind.als
sig Card {suit: Suit}
sig Suit {}
pred ThreeOfAKind (hand: set Card) {
	#hand.suit = 1 and #hand = 3
	}

run ThreeOfAKind for 6
