Class {
	#name : #NgramNoSmoothing,
	#superclass : #NgramSmoothing,
	#category : #'AI-NgramModel'
}

{ #category : #'as yet unclassified' }
NgramNoSmoothing >> smoothedProbabilityOfNgram: ngram [
	"Probability of n-gram is a conditional probability of its last word w given the history h (n-gram of order n-1): P(w|h) = C(hw) / C(h)"
	| ngramCount historyCount |
	ngramCount := self model countOfNgram: ngram.
	
	(ngramCount = 0)
		ifTrue: [ ^ 0 ].
	
	historyCount := self model countOfHistory: ngram history.
	^ ngramCount / historyCount  asFloat
]
