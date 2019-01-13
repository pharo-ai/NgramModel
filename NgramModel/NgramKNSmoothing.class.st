Class {
	#name : #NgramKNSmoothing,
	#superclass : #NgramInterpolationSmoothing,
	#type : #variable,
	#instVars : [
		'absoluteDiscount'
	],
	#category : #NgramModel
}

{ #category : #'as yet unclassified' }
NgramKNSmoothing class >> withAbsoluteDiscount: aNumber [
	^ self new absoluteDiscount: aNumber; yourself
]

{ #category : #accessing }
NgramKNSmoothing >> absoluteDiscount [
	^ absoluteDiscount
]

{ #category : #accessing }
NgramKNSmoothing >> absoluteDiscount: aNumber [
	absoluteDiscount := aNumber 
]

{ #category : #'as yet unclassified' }
NgramKNSmoothing >> continuationCountOf: aWord [ 
	^ self countOfUniqueBigramsEndingWith: aWord.
]

{ #category : #'as yet unclassified' }
NgramKNSmoothing >> countOfLowerNgram: ngram [
	(ngram order = 0) ifTrue: [ ^ 1 / self model vocabularySize ].
	^ self continuationCountOf: ngram last
]

{ #category : #'as yet unclassified' }
NgramKNSmoothing >> discountFor: ngram [
	^ self absoluteDiscount
]

{ #category : #'as yet unclassified' }
NgramKNSmoothing >> weightFor: ngram [
	^ (self discountFor: ngram) * (self countOfUniqueNgramsWithHistory: ngram history) / (self countOfNgram: ngram history)
]
