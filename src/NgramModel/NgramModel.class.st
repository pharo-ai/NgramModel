Class {
	#name : #NgramModel,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'order',
		'smoothingTechnique',
		'ngramCounts',
		'historyCounts',
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
	| defaultSmoothingTechnique |
	defaultSmoothingTechnique := NgramNoSmoothing new.
	^ self order: aNumber withSmoothing: defaultSmoothingTechnique
]

{ #category : #accessing }
NgramModel class >> order: aNumber withSmoothing: aSmoothingTechnique [
	^ super new
		initializeOrder: aNumber andSmoothing: aSmoothingTechnique;
		yourself.
]

{ #category : #counts }
NgramModel >> countOfHistory: ngram [
	^ historyCounts occurrencesOf: ngram
]

{ #category : #counts }
NgramModel >> countOfNgram: ngram [
	^ ngramCounts occurrencesOf: ngram
]

{ #category : #counts }
NgramModel >> countOfUniqueNgramsEndingWith: aWord [
	^ (ngramCounts asSet select: [ :ngram | ngram last = aWord ]) size
]

{ #category : #counts }
NgramModel >> countOfUniqueNgramsWithHistory: ngram [
	^ (ngramCounts asSet
		select: [ :eachNgram | eachNgram history = ngram ]) size.
]

{ #category : #accessing }
NgramModel >> historyCounts [
	^ historyCounts
]

{ #category : #initialization }
NgramModel >> initialize [ 
	super initialize.
	ngramCounts := Bag new.
	historyCounts := Bag new.
	vocabulary := Set with: String new defaultNgramPadding.
]

{ #category : #initialization }
NgramModel >> initializeOrder: aNumber andSmoothing: aSmoothingTechnique [
	order := aNumber.
	smoothingTechnique := aSmoothingTechnique.
	smoothingTechnique model: self
]

{ #category : #generation }
NgramModel >> mostLikelyContinuation: history [
	| ngramsWithHistory topOne |
	ngramsWithHistory := ngramCounts select: [ :ngram | ngram history = history ].
	topOne := ngramsWithHistory sortedCounts first value.
	^ topOne last
]

{ #category : #generation }
NgramModel >> mostLikelyContinuations: history top: aNumber [
	| ngramsWithHistory topOnes |
	ngramsWithHistory := ngramCounts select: [ :ngram | ngram history = history ].
	ngramsWithHistory := ngramsWithHistory sortedCounts.
	topOnes := (ngramsWithHistory first: (aNumber min: ngramsWithHistory size)) collect: #value.
	^ topOnes collect: #last
]

{ #category : #accessing }
NgramModel >> order [ 
	^ order
]

{ #category : #probabilities }
NgramModel >> probabilityOfNgram: ngram [
	"Probability of n-gram is a conditional probability of its last word w given the history h (n-gram of order n-1): P(w|h)"
	^ self smoothingTechnique smoothedProbabilityOfNgram: ngram
]

{ #category : #probabilities }
NgramModel >> probabilityOfSequence: aCollectionOfWords [
	| ngrams |
	ngrams := aCollectionOfWords ngramsWithDefaultPadding: self order.
	^ (ngrams collect: [ :ngram | self probabilityOfNgram: ngram ])
		inject: 1 into: [ :prod :each | prod * each ].
]

{ #category : #probabilities }
NgramModel >> probabilityOfText: aString [
	| ngrams |
	ngrams := aString ngramsWithDefaultPadding: self order.
	^ (ngrams collect: [ :ngram | self probabilityOfNgram: ngram ])
		inject: 1 into: [ :prod :each | prod * each ].
]

{ #category : #filtering }
NgramModel >> removeNgramsWithCountsLessThan: aNumber [
	| shouldBeRemoved |
	
	ngramCounts := ngramCounts rejectWithOccurrences: [ :each :count |
		shouldBeRemoved := count < aNumber.
		
		shouldBeRemoved ifTrue: [ 
			historyCounts remove: each history ].
		
		shouldBeRemoved ].
]

{ #category : #utilities }
NgramModel >> saveCounts: aDictionary toFile: aFileReference [
	| stream |
	stream := aFileReference writeStream.
	aDictionary associationsDo: [ :each |
		stream nextPutAll: (' ' join: each key asArray, ',', each value asString); cr ].
	stream close
]

{ #category : #utilities }
NgramModel >> saveToDirectory: aDirectory [

	self saveCounts: ngramCounts toFile: aDirectory / 'ngram_counts.csv'.
	self saveCounts: historyCounts toFile: aDirectory / 'history_counts.csv'.
	self saveVocabularyToFile: aDirectory / 'vocabulary.csv'
]

{ #category : #utilities }
NgramModel >> saveVocabularyToFile: aFileReference [
	| stream |
	stream := aFileReference writeStream.
	vocabulary do: [ :each | stream nextPutAll: each asString; cr ].
	stream close
]

{ #category : #accessing }
NgramModel >> smoothingTechnique [
	^ smoothingTechnique 
]

{ #category : #accessing }
NgramModel >> totalNgramCountInText [
	^ ngramCounts size
]

{ #category : #training }
NgramModel >> trainOn: aCollectionOfSentences [
	aCollectionOfSentences do: [ :each |
		self trainOnSentence: each ]
]

{ #category : #training }
NgramModel >> trainOnSentence: aCollectionOrString [
	| ngrams |
	ngrams := aCollectionOrString ngramsWithDefaultPadding: self order.
		
	ngrams do: [ :each |
		ngramCounts add: each.
		historyCounts add: each history.
		vocabulary addAll: each asArray ].
]

{ #category : #accessing }
NgramModel >> vocabulary [
	^ vocabulary
]
