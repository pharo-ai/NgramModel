Class {
	#name : #AINgramPerplexity,
	#superclass : #AINgramModelMetric,
	#category : #'AI-NgramModelMetrics'
}

{ #category : #'instance creation' }
AINgramPerplexity >> of: model on: aCollectionOfTexts [
	| perplexities |
	perplexities := aCollectionOfTexts collect: [ :aString |
		2 ** (AINgramEntropy of: model on: { aString }) ].
	^ perplexities average
]
