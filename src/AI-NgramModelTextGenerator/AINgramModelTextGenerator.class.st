Class {
	#name : #AINgramModelTextGenerator,
	#superclass : #Object,
	#instVars : [
		'model',
		'history'
	],
	#category : #'AI-NgramModelTextGenerator'
}

{ #category : #initialization }
AINgramModelTextGenerator >> generateTextOfSize: aNumber [
	| words |
	words := OrderedCollection new.
	
	(1 to: aNumber) do: [ :i | 
		words add: self nextWord
	] displayingProgress:  [ :each | 'Generating words: ' , each asString ].

	^ ' ' join: words
]

{ #category : #initialization }
AINgramModelTextGenerator >> model: anObject [
	| order |
	model := anObject.
	order := model order - 1.
	history := ((1 to: order) collect: [ :x | '<s>' ]) asNgram.
]

{ #category : #initialization }
AINgramModelTextGenerator >> nextWord [
	| word |
	word := (model mostLikelyContinuations: history top: 5) atRandom.
	history := (history asArray copyWithoutFirst, { word }) asNgram.
	^ word
]
