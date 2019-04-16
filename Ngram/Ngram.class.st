Class {
	#name : #Ngram,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'history',
		'last'
	],
	#category : #Ngram
}

{ #category : #'instance creation' }
Ngram class >> fromArray: anArray [
	| ngram |
	ngram := self new.
	
	anArray ifEmpty: [ ^ngram ].
	
	ngram history: (anArray copyFrom: 1 to: (anArray size - 1)).
	ngram last: anArray last.
	^ ngram
]

{ #category : #'instance creation' }
Ngram class >> with: anObject [
	^ self new last: anObject; yourself.
]

{ #category : #'as yet unclassified' }
Ngram class >> with: firstObject with: secondObject [
	^ self new history: { firstObject }; last: secondObject; yourself.
]

{ #category : #'as yet unclassified' }
Ngram class >> with: firstObject with: secondObject with: thirdObject [
	^ self new history: { firstObject . secondObject }; last: thirdObject; yourself.
]

{ #category : #'as yet unclassified' }
Ngram class >> with: firstObject with: secondObject with: thirdObject with: fourthObject [
	^ self new history: { firstObject . secondObject . thirdObject }; last: fourthObject; yourself.
]

{ #category : #'as yet unclassified' }
Ngram class >> with: firstObject with: secondObject with: thirdObject with: fourthObject with: fifthObject [
	^ self new history: { firstObject . secondObject . thirdObject . fourthObject }; last: fifthObject; yourself.
]

{ #category : #comparing }
Ngram >> = anObject [
	(anObject isKindOf: self class)
		ifFalse: [ ^ false ].
		
	^ self asArray = anObject asArray
]

{ #category : #converting }
Ngram >> asArray [ 
	^ history copyWith: last
]

{ #category : #comparing }
Ngram >> hash [
	^ self asArray hash
]

{ #category : #accessing }
Ngram >> history [ 
	^ history asNgram
]

{ #category : #accessing }
Ngram >> history: aCollection [ 
	history := aCollection asArray
]

{ #category : #initialization }
Ngram >> initialize [ 
	history := Array new.
]

{ #category : #accessing }
Ngram >> last [
	^ last
]

{ #category : #accessing }
Ngram >> last: anObject [
	last := anObject
]

{ #category : #accessing }
Ngram >> order [ 
	last ifNil: [ ^ 0 ].
	^ history size + 1
]

{ #category : #converting }
Ngram >> printOn: aStream [
	aStream nextPutAll: 'n-gram'; nextPut: $(.
	
	history ifNotEmpty: [ 
		history do: [ :each |
			each printOn: aStream.
			aStream space ] ].
	
	last printOn: aStream.
	aStream nextPut: $).
]
