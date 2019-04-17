Class {
	#name : #NgramSmoothing,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'model'
	],
	#category : #NgramModel
}

{ #category : #accessing }
NgramSmoothing >> model [ 
	^ model
]

{ #category : #accessing }
NgramSmoothing >> model: aModel [
	model := aModel
]

{ #category : #'as yet unclassified' }
NgramSmoothing >> smoothedProbabilityOfNgram: ngram [
	self subclassResponsibility 
]
