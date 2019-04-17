Class {
	#name : #Perplexity,
	#superclass : #NgramModelMetric,
	#category : #NgramModelMetrics
}

{ #category : #'instance creation' }
Perplexity >> of: model on: aCollectionOfTexts [
	| perplexities |
	perplexities := aCollectionOfTexts collect: [ :aString |
		2 ** (Entropy of: model on: { aString }) ].
	^ perplexities average
]
