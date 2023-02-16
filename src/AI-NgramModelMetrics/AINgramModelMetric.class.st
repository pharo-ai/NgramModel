Class {
	#name : #AINgramModelMetric,
	#superclass : #Object,
	#category : #'AI-NgramModelMetrics'
}

{ #category : #'instance creation' }
AINgramModelMetric class >> of: aModel on: aData [
	^ self new of: aModel on: aData
]

{ #category : #'instance creation' }
AINgramModelMetric >> of: aModel on: aData [
	self subclassResponsibility
]
