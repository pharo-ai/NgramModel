Class {
	#name : #NgramAddKSmoothing,
	#superclass : #NgramSmoothing,
	#type : #variable,
	#instVars : [
		'k'
	],
	#category : #NgramModel
}

{ #category : #'as yet unclassified' }
NgramAddKSmoothing class >> withK: aNumber [
	^ super new k: aNumber; yourself
]

{ #category : #'as yet unclassified' }
NgramAddKSmoothing >> k [
	^ k
]

{ #category : #'as yet unclassified' }
NgramAddKSmoothing >> k: aNumber [
	k := aNumber
]

{ #category : #'as yet unclassified' }
NgramAddKSmoothing >> smoothedProbabilityOfNgram: ngram [
	| ngramCount historyCount |
	ngramCount := self model countOfNgram: ngram.
	
	historyCount := self model countOfHistory: ngram history.
	^ (ngramCount + self k) / (historyCount + (self k * self model vocabularySize)) asFloat
]
