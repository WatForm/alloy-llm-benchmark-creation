sig Card {suit: Suit}
sig Suit {}

fact ThreeOfAKind {
    some hand: set Card | {
        #hand = 3 and #hand.suit = 1 
    }
}
