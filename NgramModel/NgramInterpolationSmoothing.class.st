Class {
	#name : #NgramInterpolationSmoothing,
	#superclass : #NgramSmoothing,
	#type : #variable,
	#instVars : [
		'lowerNgramCounts'
	],
	#category : #NgramModel
}

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> countOfHighestNgram: ngram [
	^ self model countOfNgram: ngram
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> countOfLowerNgram: ngram [
	^ self countOfNgram: ngram
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> countOfNgram: ngram [
	| order |
	order := ngram order.
	"For 0-gram return count of all unigrams"
	(order = 0) ifTrue: [ ^ lowerNgramCounts first size ].
	^ (lowerNgramCounts at: order) occurrencesOf: ngram.
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> countOfUniqueBigramsEndingWith: aWord [
	(self highestOrder = 2)
		ifTrue: [ ^ self model countOfUniqueNgramsEndingWith: aWord ].
		
	^ ((lowerNgramCounts at: 2) asSet select: [ :ngram | ngram last = aWord ]) size
	
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> countOfUniqueNgramsWithHistory: ngram [
	| order |
	order := ngram order + 1.
	(order = self highestOrder) ifTrue: [ ^ self model countOfUniqueNgramsWithHistory: ngram ].
	^ ((lowerNgramCounts at: order) asSet
		select: [ :eachNgram | eachNgram history = ngram ]) size.
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> discountFor: ngram [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> highestOrder [
	^ self model order
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> postTraining [
	"Counts n-grams of lower orders" 
	| order |
	
	lowerNgramCounts := (1 to: self highestOrder - 1)
		collect: [ :i | Bag new ].
	
	lowerNgramCounts at: (self highestOrder - 1) put: self model historyCounts.
	
	2 to: self highestOrder - 1 do: [ :k |
		order := self highestOrder - k.
		
		(lowerNgramCounts at: order + 1) doWithOccurrences: [ :ngram :count |
			(lowerNgramCounts at: order) add: ngram withOccurrences: count ] ]
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> probabilityOfHighestNgram: ngram [
	| count historyCount discount |
	count := self countOfHighestNgram: ngram.
	historyCount := self countOfLowerNgram: ngram history.
	discount := self discountFor: count.
	^ ((count - discount) max: 0) / historyCount 
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> probabilityOfNgram: ngram [
	| count historyCount discount |
	count := self countOfLowerNgram: ngram.
	historyCount := self countOfLowerNgram: ngram history.
	discount := self discountFor: count.
	^ ((count - discount) max: 0) / historyCount 
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> smoothedProbabilityOfLowerOrders: ngram [
	(ngram order = 0)
		ifTrue: [ ^ 1 / self model vocabularySize ].
		
	^ (self weightFor: ngram) * (self probabilityOfNgram: ngram) + (self smoothedProbabilityOfLowerOrders: ngram history)
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> smoothedProbabilityOfNgram: ngram [
	^ (self weightFor: ngram) * (self probabilityOfHighestNgram: ngram) + (self smoothedProbabilityOfLowerOrders: ngram history)
]

{ #category : #'as yet unclassified' }
NgramInterpolationSmoothing >> weightFor: ngram [
	self subclassResponsibility
]
