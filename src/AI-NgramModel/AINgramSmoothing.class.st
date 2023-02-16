Class {
	#name : #AINgramSmoothing,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'AI-NgramModel'
}

{ #category : #accessing }
AINgramSmoothing >> model [ 
	^ model
]

{ #category : #accessing }
AINgramSmoothing >> model: aModel [
	model := aModel
]

{ #category : #'as yet unclassified' }
AINgramSmoothing >> smoothedProbabilityOfNgram: ngram [
	self subclassResponsibility 
]
