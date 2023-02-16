Class {
	#name : #NgramModelMetric,
	#superclass : #Object,
	#category : #'AI-NgramModelMetrics'
}

{ #category : #'instance creation' }
NgramModelMetric class >> of: aModel on: aData [
	^ self new of: aModel on: aData
]

{ #category : #'instance creation' }
NgramModelMetric >> of: aModel on: aData [
	self subclassResponsibility
]
