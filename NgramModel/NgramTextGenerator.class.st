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
	| words |
	words := OrderedCollection new.
	
	(1 to: aNumber) do: [ :i | 
		words add: self nextWord
	] displayingProgress:  [ :each | 'Generating words: ' , each asString ].

	^ ' ' join: words
]

{ #category : #initialization }
NgramTextGenerator >> model: anObject [
	| order |
	model := anObject.
	order := model order - 1.
	history := ((1 to: order) collect: [ :x | '<s>' ]) asNgram.
]

{ #category : #initialization }
NgramTextGenerator >> nextWord [
	| word |
	word := (model mostLikelyContinuations: history top: 5) atRandom.
	history := (history asArray copyWithoutFirst, { word }) asNgram.
	^ word
]
