Class {
	#name : #NgramModelSmoothing,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'model'
	],
	#category : #NgramModel
}

{ #category : #accessing }
NgramModelSmoothing >> model [ 
	^ model
]

{ #category : #accessing }
NgramModelSmoothing >> model: aModel [
	model := aModel
]

{ #category : #'as yet unclassified' }
NgramModelSmoothing >> postTraining [
	"Do nothing"
]

{ #category : #'as yet unclassified' }
NgramModelSmoothing >> smoothedProbabilityOfNgram: ngram [
	self subclassResponsibility 
]
