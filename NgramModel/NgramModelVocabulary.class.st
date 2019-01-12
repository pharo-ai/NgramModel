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
	| ngrams |
	ngrams := (self recursiveNgramWithHistory: Array new maxOrder: order)
		flatCollect: #value.
		
	ngrams := ngrams asSet.
	ngrams remove: ((1 to: order) collect: [ :x | '<s>' ]) asNgram.
	
	^ ngrams
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
	words := Bag with: self padSymbol with: self unknownSymbol.
]

{ #category : #accessing }
NgramModelVocabulary >> isEmpty [
	^ words isEmpty
]

{ #category : #initialization }
NgramModelVocabulary >> numberOfReservedTokens [
	^ 2
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

{ #category : #accessing }
NgramModelVocabulary >> unknownSymbol [
	^ '<unk>'
]

{ #category : #initialization }
NgramModelVocabulary >> words [
	^ words asSet
]
