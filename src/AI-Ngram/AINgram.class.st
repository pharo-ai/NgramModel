Class {
	#name : #AINgram,
	#superclass : #Object,
	#instVars : [
		'history',
		'last'
	],
	#category : #'AI-Ngram'
}

{ #category : #'instance creation' }
AINgram class >> withElements: aCollection [
	"Creates n-gram from a collection of n elements"
	aCollection isEmpty ifTrue: [ ^ self zerogram ].
	^ self
		withHistory: (self withElements: aCollection allButLast)
		last: aCollection last.
]

{ #category : #'instance creation' }
AINgram class >> withHistory: aNgram last: anObject [
	"Creates n-gram with aNgram as history and anObject as last element"
	^ self new
		history: aNgram;
		last: anObject;
		yourself.
]

{ #category : #'instance creation' }
AINgram class >> zerogram [
	"Creates n-gram of order 0. It is an empty n-gram that has no elements"
	^ self new.
]

{ #category : #comparing }
AINgram >> = anObject [
	(anObject isKindOf: self class)
		ifFalse: [ ^ false ].
		
	^ self asArray = anObject asArray
]

{ #category : #converting }
AINgram >> asArray [ 
	self isEmpty ifTrue: [ ^ #() ].
	^ history asArray copyWith: last
]

{ #category : #comparing }
AINgram >> hash [
	^ self asArray hash
]

{ #category : #accessing }
AINgram >> history [
	self isEmpty ifTrue: [ ^ self class zerogram ].
	^ history
]

{ #category : #accessing }
AINgram >> history: aNgram [ 
	history := aNgram
]

{ #category : #accessing }
AINgram >> isEmpty [ 
	^ self last isNil
]

{ #category : #accessing }
AINgram >> last [
	^ last
]

{ #category : #accessing }
AINgram >> last: anObject [
	last := anObject
]

{ #category : #accessing }
AINgram >> order [ 
	self isEmpty ifTrue: [ ^ 0 ].
	^ history order + 1
]

{ #category : #converting }
AINgram >> printOn: aStream [
	aStream
		nextPutAll: 'n-gram';
		nextPut: $(;
		nextPutAll: (' ' join: self asArray);
		nextPut: $).
]
