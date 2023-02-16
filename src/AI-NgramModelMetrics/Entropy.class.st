Class {
	#name : #Entropy,
	#superclass : #NgramModelMetric,
	#category : #'AI-NgramModelMetrics'
}

{ #category : #accessing }
Entropy >> logarithmBase [
	^ 2
]

{ #category : #'instance creation' }
Entropy >> of: model on: aCollectionOfTexts [
	| entropies |
	entropies := aCollectionOfTexts collect: [ :aString |
		self of: model onText: aString ].
	^ entropies average
]

{ #category : #'instance creation' }
Entropy >> of: model onNgrams: ngrams [
	^ -1 * 1 / ngrams size asFloat * (ngrams collect: [ :ngram |
		(model probabilityOfNgram: ngram) log: self logarithmBase ]) sum.
]

{ #category : #'instance creation' }
Entropy >> of: model onText: aString [
	| ngrams |
	ngrams := aString ngramsWithDefaultPadding: model order.
	^ self of: model onNgrams: ngrams.
]
