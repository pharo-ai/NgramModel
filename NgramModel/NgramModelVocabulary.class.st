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

{ #category : #'as yet unclassified' }
NgramModelVocabulary >> allNgramsOfOrder: order [
	^ (self recursiveNgramWithHistory: Array new maxOrder: order)
		flatCollect: #asNgram.
]

{ #category : #initialization }
NgramModelVocabulary >> initialize [
	super initialize.
	words := Bag with: self padSymbol with: self unknownSymbol.
]

{ #category : #accessing }
NgramModelVocabulary >> isEmpty [
	^ words isEmpty
]

{ #category : #accessing }
NgramModelVocabulary >> padSymbol [
	^ '<s>'
]

{ #category : #accessing }
NgramModelVocabulary >> recursiveNgramWithHistory: history maxOrder: order [
	(history size = order)
		ifTrue: [ ^ { history } ].
		
	^ words flatCollect: [ :word |
		self recursiveNgramWithHistory: (history copyWith: word) maxOrder: order ].
]

{ #category : #accessing }
NgramModelVocabulary >> size [
	^ self words size
]

{ #category : #accessing }
NgramModelVocabulary >> unknownSymbol [
	^ '<unk>'
]

{ #category : #initialization }
NgramModelVocabulary >> words [
	^ words asSet
]
