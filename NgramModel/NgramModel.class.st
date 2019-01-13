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

{ #category : #metrics }
NgramModel >> crossEntropyOn: aText [
	| ngrams |
	ngrams := aText ngrams: self order pad: self vocabulary padSymbol.
	^ -1 * 1 / ngrams size asFloat * (ngrams collect: [ :ngram |
		(self probabilityOfNgram: ngram) log: self logarithmBase ]) sum.
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
	vocabulary := NgramModelVocabulary new.
]

{ #category : #initialization }
NgramModel >> initializeOrder: aNumber andSmoothing: aSmoothingTechnique [
	order := aNumber.
	smoothingTechnique := aSmoothingTechnique.
	smoothingTechnique model: self
]

{ #category : #constants }
NgramModel >> logarithmBase [
	^ 2
]

{ #category : #probabilities }
NgramModel >> mostLikelyContinuation: history [
	| ngramsWithHistory topOne |
	ngramsWithHistory := ngramCounts select: [ :ngram | ngram history = history ].
	topOne := ngramsWithHistory sortedCounts first value.
	^ topOne last
]

{ #category : #probabilities }
NgramModel >> mostLikelyContinuations: history top: aNumber [
	| ngramsWithHistory lo topOnes |
	ngramsWithHistory := ngramCounts select: [ :ngram | ngram history = history ].
	ngramsWithHistory := ngramsWithHistory sortedCounts.
	lo := (ngramsWithHistory size - aNumber + 1) max: 1.
	topOnes := (ngramsWithHistory copyFrom: lo to: ngramsWithHistory size) collect: #value.
	^ topOnes collect: #last
]

{ #category : #accessing }
NgramModel >> order [ 
	^ order
]

{ #category : #metrics }
NgramModel >> perplexityOn: aText [
	^ 2 ** (self crossEntropyOn: aText)
]

{ #category : #probabilities }
NgramModel >> probabilityOfNgram: ngram [
	"Probability of n-gram is a conditional probability of its last word w given the history h (n-gram of order n-1): P(w|h)"
	^ self smoothingTechnique smoothedProbabilityOfNgram: ngram
]

{ #category : #probabilities }
NgramModel >> probabilityOfText: aString [
	| ngrams |
	ngrams := aString ngrams: self order pad: self vocabulary padSymbol.
	^ (ngrams collect: [ :ngram | self probabilityOfNgram: ngram ])
		inject: 1 into: [ :prod :each | prod * each ].
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
NgramModel >> trainOn: aString [
	| ngrams words |
	ngrams := aString
		ngrams: self order
		pad: self vocabulary padSymbol.
		
	ngramCounts := ngrams asBag.
	ngramCounts doWithOccurrences: [ :ngram :count |
		historyCounts add: ngram history withOccurrences: count ].
	
	vocabulary clear.
	vocabulary add: vocabulary padSymbol.
	words := aString unigrams flatCollect: #asArray.
	words do: [ :word | self vocabulary add: word ].
	
	self smoothingTechnique postTraining
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

{ #category : #metrics }
NgramModel >> withProgressBarCrossEntropyOn: aText [
	| ngrams ngram entropy |
	ngrams := aText ngrams: self order pad: self vocabulary padSymbol.
	
	entropy := 0.
	
	(1 to: ngrams size) do: [ :i |
		ngram := ngrams at: i.
		entropy := entropy + ((self probabilityOfNgram: ngram) log: self logarithmBase)
	] displayingProgress:  [ :each | 'Approximating cross-entropy: ' , (-1 * 1 / each asFloat * entropy) asString ].
	
	entropy := -1 * 1 / ngrams size asFloat * entropy.
	^ entropy
]
