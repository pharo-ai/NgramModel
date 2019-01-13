Class {
	#name : #NgramModelAddKSmoothing,
	#superclass : #NgramModelSmoothing,
	#type : #variable,
	#instVars : [
		'k'
	],
	#category : #NgramModel
}

{ #category : #'as yet unclassified' }
NgramModelAddKSmoothing class >> new [ 	
	self shouldNotImplement 
]

{ #category : #'as yet unclassified' }
NgramModelAddKSmoothing class >> withK: aNumber [
	^ super new k: aNumber; yourself
]

{ #category : #'as yet unclassified' }
NgramModelAddKSmoothing >> k [
	^ k
]

{ #category : #'as yet unclassified' }
NgramModelAddKSmoothing >> k: aNumber [
	k := aNumber
]

{ #category : #'as yet unclassified' }
NgramModelAddKSmoothing >> smoothedProbabilityOfNgram: ngram [
	| ngramCount historyCount |
	ngramCount := self model countOfNgram: ngram.
	
	historyCount := self model countOfHistory: ngram history.
	^ (ngramCount + self k) / (historyCount + (self k * self model vocabularySize)) asFloat
]
