Class {
	#name : #NgramOrderError,
	#superclass : #Error,
	#type : #variable,
	#instVars : [
		'expectedOrder',
		'receivedOrder'
	],
	#category : #NgramModel
}

{ #category : #signalling }
NgramOrderError class >> signal [ 
	self shouldNotImplement 
]

{ #category : #signalling }
NgramOrderError class >> signal: anObject [
	self shouldNotImplement 
]

{ #category : #signalling }
NgramOrderError class >> signalExpected: expected received: received [
	^ (self new expectedOrder: expected receivedOrder: received) signal
]

{ #category : #'as yet unclassified' }
NgramOrderError >> expectedOrder: expected receivedOrder: received [
	expectedOrder := expected.
	receivedOrder := received.
]

{ #category : #accessing }
NgramOrderError >> messageText [
	^ 'Expected n-gram of order ', expectedOrder asString, ' but received order ', receivedOrder asString
]
