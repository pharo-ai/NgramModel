Class {
	#name : #NgramModel,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'order',
		'ngramCounts',
		'vocabulary'
	],
	#category : #NgramModel
}

{ #category : #accessing }
NgramModel class >> new [ 
	self shouldNotImplement 
]

{ #category : #accessing }
NgramModel class >> order: aNumber [
	^ super new initializeOrder: aNumber
]

{ #category : #counts }
NgramModel >> countOfNgram: ngram [
	(ngram order = self order)
		ifFalse: [ NgramOrderError signalExpected: self order received: ngram order ].
		
	^ ngramCounts occurrencesOf: ngram
]

{ #category : #metrics }
NgramModel >> crossEntropyOn: aText [
	| ngrams |
	ngrams := aText ngrams: self order pad: self vocabulary padSymbol.
	^ -1 * 1 / ngrams size asFloat * (ngrams collect: [ :ngram |
		(self probabilityOfNgram: ngram) log: self logarithmBase ]) sum.
]

{ #category : #initialization }
NgramModel >> initialize [ 
	super initialize.
	ngramCounts := Bag new.
	vocabulary := NgramModelVocabulary new.
]

{ #category : #initialization }
NgramModel >> initializeOrder: aNumber [
	order := aNumber.
]

{ #category : #constants }
NgramModel >> logarithmBase [
	^ 2
]

{ #category : #accessing }
NgramModel >> order [ 
	^ order
]

{ #category : #probabilities }
NgramModel >> probabilityOfNgram: ngram [
	self wasTrained
		ifFalse: [ NgramEmptyModelError signal ].

	^ (self countOfNgram: ngram) / self totalNgramCount asFloat
]

{ #category : #probabilities }
NgramModel >> probabilityOfText: aString [
	| ngrams |
	ngrams := aString ngrams: self order pad: self vocabulary padSymbol.
	^ (ngrams collect: [ :ngram | self probabilityOfNgram: ngram ])
		inject: 1 into: [ :prod :each | prod * each ].
]

{ #category : #accessing }
NgramModel >> totalNgramCount [
	^ ngramCounts size
]

{ #category : #training }
NgramModel >> trainOn: aString [
	| ngrams words |
	ngrams := aString
		ngrams: self order
		pad: self vocabulary padSymbol.
		
	ngramCounts := ngrams asBag.
	
	words := aString unigrams flatCollect: #asArray.
	words do: [ :word | self vocabulary add: word ].
]

{ #category : #accessing }
NgramModel >> vocabulary [
	^ vocabulary
]

{ #category : #accessing }
NgramModel >> vocabularySize [
	^ self vocabulary size
]

{ #category : #testing }
NgramModel >> wasTrained [
	^ self vocabulary size > (self vocabulary numberOfReservedTokens)
]
