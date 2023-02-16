Class {
	#name : #AINgramAddKSmoothing,
	#superclass : #AINgramSmoothing,
	#instVars : [
		'k'
	],
	#category : #'AI-NgramModel'
}

{ #category : #'as yet unclassified' }
AINgramAddKSmoothing class >> withK: aNumber [
	^ super new k: aNumber; yourself
]

{ #category : #'as yet unclassified' }
AINgramAddKSmoothing >> k [
	^ k
]

{ #category : #'as yet unclassified' }
AINgramAddKSmoothing >> k: aNumber [
	k := aNumber
]

{ #category : #'as yet unclassified' }
AINgramAddKSmoothing >> smoothedProbabilityOfNgram: ngram [
	| ngramCount historyCount |
	ngramCount := self model countOfNgram: ngram.
	historyCount := self model countOfHistory: ngram history.
	^ (ngramCount + self k) / (historyCount + (self k * self model vocabulary size)) asFloat
]
