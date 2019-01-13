Class {
	#name : #NgramModelLaplaceSmoothing,
	#superclass : #NgramModelSmoothing,
	#type : #variable,
	#category : #NgramModel
}

{ #category : #'as yet unclassified' }
NgramModelLaplaceSmoothing >> smoothedProbabilityOfNgram: ngram [
	| ngramCount historyCount |
	ngramCount := self model countOfNgram: ngram.
	
	historyCount := self model countOfHistory: ngram history.
	^ (ngramCount + 1) / (historyCount + self model vocabularySize) asFloat
]
