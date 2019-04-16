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
	"Creates n-gram from an array of n elements"
	anArray isEmpty ifTrue: [ ^ self zerogram ].
	^ self
		withHistory: (self fromArray: (anArray copyWithoutIndex: anArray size))
		last: anArray last.
]

{ #category : #'instance creation' }
Ngram class >> new [ 
	"Either use zerogram to create an empty n-gram or provide values"
	self shouldNotImplement
]

{ #category : #'instance creation' }
Ngram class >> withHistory: aNgram last: anObject [
	"Creates n-gram with aNgram as history and anObject as last element"
	^ super new
		history: aNgram;
		last: anObject;
		yourself.
]

{ #category : #'instance creation' }
Ngram class >> zerogram [
	"Creates n-gram of order 0. It is an empty n-gram that has no elements"
	^ super new.
]

{ #category : #comparing }
Ngram >> = anObject [
	(anObject isKindOf: self class)
		ifFalse: [ ^ false ].
		
	^ self asArray = anObject asArray
]

{ #category : #converting }
Ngram >> asArray [ 
	self isEmpty ifTrue: [ ^ #() ].
	^ history asArray copyWith: last
]

{ #category : #comparing }
Ngram >> hash [
	^ self asArray hash
]

{ #category : #accessing }
Ngram >> history [
	self isEmpty ifTrue: [ ^ self class zerogram ].
	^ history
]

{ #category : #accessing }
Ngram >> history: aNgram [ 
	history := aNgram
]

{ #category : #accessing }
Ngram >> isEmpty [ 
	^ self last isNil
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
	self isEmpty ifTrue: [ ^ 0 ].
	^ history order + 1
]

{ #category : #converting }
Ngram >> printOn: aStream [
	aStream
		nextPutAll: 'n-gram';
		nextPut: $(;
		nextPutAll: (' ' join: self asArray);
		nextPut: $).
]
