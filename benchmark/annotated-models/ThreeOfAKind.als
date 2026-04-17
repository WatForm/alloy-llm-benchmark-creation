sig Card {suit: Suit}
sig Suit {}
fact ThreeOfAKind (hand: set Card) {
	#hand.suit = 1 and #hand = 3
	}

