Class {
	#name : #NgramTextGenerator,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'model',
		'history'
	],
	#category : #NgramModel
}

{ #category : #initialization }
NgramTextGenerator >> generateTextOfSize: aNumber [
	^ ' ' join: ((1 to: aNumber) collect: [ :i | self nextWord ]).
]

{ #category : #initialization }
NgramTextGenerator >> initialize [ 
	super initialize.
	history := #('<s>') asNgram
]

{ #category : #initialization }
NgramTextGenerator >> model: anObject [
	model := anObject
]

{ #category : #initialization }
NgramTextGenerator >> nextWord [
	| word |
	word := (model mostLikelyContinuations: history top: 5) atRandom.
	history := { word } asNgram.
	^ word
]
