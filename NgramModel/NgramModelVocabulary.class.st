Class {
	#name : #NgramModelVocabulary,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'words'
	],
	#category : #NgramModel
}

{ #category : #initialization }
NgramModelVocabulary >> add: anObject [
	words add: anObject
]

{ #category : #initialization }
NgramModelVocabulary >> clear [ 
	self initializeEmptyVocabulary 
]

{ #category : #initialization }
NgramModelVocabulary >> initialize [
	super initialize.
	self initializeEmptyVocabulary 
]

{ #category : #initialization }
NgramModelVocabulary >> initializeEmptyVocabulary [
	words := Bag new.
]

{ #category : #accessing }
NgramModelVocabulary >> isEmpty [
	^ words isEmpty
]

{ #category : #initialization }
NgramModelVocabulary >> numberOfReservedTokens [
	^ 1
]

{ #category : #accessing }
NgramModelVocabulary >> padSymbol [
	^ '<s>'
]

{ #category : #accessing }
NgramModelVocabulary >> recursiveNgramWithHistory: history maxOrder: order [
	(history size = order)
		ifTrue: [ ^ { { history asNgram } } ].
		
	^ words asArray flatCollect: [ :word |
		self recursiveNgramWithHistory: (history copyWith: word) maxOrder: order ].
]

{ #category : #accessing }
NgramModelVocabulary >> size [
	^ self words size
]

{ #category : #initialization }
NgramModelVocabulary >> words [
	^ words asSet
]
