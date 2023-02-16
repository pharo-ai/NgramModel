Class {
	#name : #AINgramModel,
	#superclass : #Object,
	#instVars : [
		'order',
		'smoothingTechnique',
		'ngramCounts',
		'historyCounts',
		'vocabulary'
	],
	#category : #'AI-NgramModel'
}

{ #category : #accessing }
AINgramModel class >> order: aNumber [
	| defaultSmoothingTechnique |
	defaultSmoothingTechnique := AINgramNoSmoothing new.
	^ self order: aNumber withSmoothing: defaultSmoothingTechnique
]

{ #category : #accessing }
AINgramModel class >> order: aNumber withSmoothing: aSmoothingTechnique [
	^ self new
		initializeOrder: aNumber andSmoothing: aSmoothingTechnique;
		yourself.
]

{ #category : #'file in/out' }
AINgramModel class >> readFromFile: aFileReference [
    ^ aFileReference readStreamDo: [ :readStream |
        STON fromStream: readStream ]
]

{ #category : #counts }
AINgramModel >> countOfHistory: ngram [
	^ historyCounts occurrencesOf: ngram
]

{ #category : #counts }
AINgramModel >> countOfNgram: ngram [
	^ ngramCounts occurrencesOf: ngram
]

{ #category : #counts }
AINgramModel >> countOfUniqueNgramsEndingWith: aWord [
	^ (ngramCounts asSet select: [ :ngram | ngram last = aWord ]) size
]

{ #category : #counts }
AINgramModel >> countOfUniqueNgramsWithHistory: ngram [
	^ (ngramCounts asSet
		select: [ :eachNgram | eachNgram history = ngram ]) size.
]

{ #category : #accessing }
AINgramModel >> historyCounts [
	^ historyCounts
]

{ #category : #initialization }
AINgramModel >> initialize [ 
	super initialize.
	ngramCounts := Bag new.
	historyCounts := Bag new.
	vocabulary := Set with: String new defaultNgramPadding.
]

{ #category : #initialization }
AINgramModel >> initializeHistoryCounts: aHistoryTable ngramCounts: anNgramTable vocabulary: aVocabulary [
	historyCounts := aHistoryTable.
	ngramCounts := anNgramTable.
	vocabulary := aVocabulary.
]

{ #category : #initialization }
AINgramModel >> initializeOrder: aNumber andSmoothing: aSmoothingTechnique [
	order := aNumber.
	smoothingTechnique := aSmoothingTechnique.
	smoothingTechnique model: self
]

{ #category : #probabilities }
AINgramModel >> logProbabilityOfText: aString [
	| ngrams |
	ngrams := aString ngramsWithDefaultPadding: self order.
	^ (ngrams collect: [ :ngram | self probabilityOfNgram: ngram ])
		inject: 0 into: [ :sum :each | sum + each log ].
]

{ #category : #generation }
AINgramModel >> mostLikelyContinuation: history [
	| ngramsWithHistory topOne |
	ngramsWithHistory := ngramCounts select: [ :ngram | ngram history = history ].
	topOne := ngramsWithHistory sortedCounts first value.
	^ topOne last
]

{ #category : #generation }
AINgramModel >> mostLikelyContinuations: history top: aNumber [
	| ngramsWithHistory topOnes |
	ngramsWithHistory := ngramCounts select: [ :ngram | ngram history = history ].
	ngramsWithHistory := ngramsWithHistory sortedCounts.
	topOnes := (ngramsWithHistory first: (aNumber min: ngramsWithHistory size)) collect: #value.
	^ topOnes collect: #last
]

{ #category : #accessing }
AINgramModel >> order [ 
	^ order
]

{ #category : #probabilities }
AINgramModel >> probabilityOfNgram: ngram [
	"Probability of n-gram is a conditional probability of its last word w given the history h (n-gram of order n-1): P(w|h)"
	^ self smoothingTechnique smoothedProbabilityOfNgram: ngram
]

{ #category : #probabilities }
AINgramModel >> probabilityOfSequence: aCollectionOfWords [
	| ngrams |
	ngrams := aCollectionOfWords ngramsWithDefaultPadding: self order.
	^ (ngrams collect: [ :ngram | self probabilityOfNgram: ngram ])
		inject: 1 into: [ :prod :each | prod * each ].
]

{ #category : #probabilities }
AINgramModel >> probabilityOfText: aString [
	| ngrams |
	ngrams := aString ngramsWithDefaultPadding: self order.
	^ (ngrams collect: [ :ngram | self probabilityOfNgram: ngram ])
		inject: 1 into: [ :prod :each | prod * each ].
]

{ #category : #filtering }
AINgramModel >> removeNgramsWithCountsLessThan: aNumber [
	| shouldBeRemoved |
	
	ngramCounts := ngramCounts rejectWithOccurrences: [ :each :count |
		shouldBeRemoved := count < aNumber.
		
		shouldBeRemoved ifTrue: [ 
			historyCounts remove: each history ].
		
		shouldBeRemoved ].
]

{ #category : #'file in/out' }
AINgramModel >> saveToFile: aFileReference [ 
    aFileReference writeStreamDo: [ :writeStream |
        STON put: self onStream: writeStream ]
]

{ #category : #accessing }
AINgramModel >> smoothingTechnique [
	^ smoothingTechnique 
]

{ #category : #accessing }
AINgramModel >> totalNgramCountInText [
	^ ngramCounts size
]

{ #category : #training }
AINgramModel >> trainOn: aCollectionOfSentences [
	aCollectionOfSentences do: [ :each |
		self trainOnSentence: each ]
]

{ #category : #training }
AINgramModel >> trainOnSentence: aCollectionOrString [
	| ngrams |
	ngrams := aCollectionOrString ngramsWithDefaultPadding: self order.
		
	ngrams do: [ :each |
		ngramCounts add: each.
		historyCounts add: each history.
		vocabulary addAll: each asArray ].
]

{ #category : #accessing }
AINgramModel >> vocabulary [
	^ vocabulary
]
