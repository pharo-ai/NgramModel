Class {
	#name : #NgramModelSmoothing,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'model'
	],
	#category : #NgramModel
}

{ #category : #'as yet unclassified' }
NgramModelSmoothing class >> forModel: aModel [
	^ super new model: aModel; yourself
]

{ #category : #'as yet unclassified' }
NgramModelSmoothing class >> new [ 
	self shouldNotImplement 
]

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
