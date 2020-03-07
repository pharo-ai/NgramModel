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

{ #category : #'file in/out' }
NgramModel class >> historyCountsFileName [
	^ 'history_counts.csv'
]

{ #category : #accessing }
NgramModel class >> new [ 
	self shouldNotImplement 
]

{ #category : #'file in/out' }
NgramModel class >> ngramCountsFileName [
	^ 'ngram_counts.csv'
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

{ #category : #'file in/out' }
NgramModel class >> readCountsFromFile: aFileReference [
	| counts stream values ngram count |
	counts := Bag new.
	stream := aFileReference readStream.
	
	
	[stream atEnd] whileFalse: [ 
		values := stream nextLine substrings: ','.
		ngram := values first substrings asNgram.
		count := values second asNumber.
		counts add: ngram withOccurrences: count ].
	
	stream close.
	^ counts
]

{ #category : #'file in/out' }
NgramModel class >> readFromDirectory: aFileReference [
	| historyCounts ngramCounts vocabulary order |
	
	historyCounts := self readCountsFromFile: (aFileReference / self historyCountsFileName).
	ngramCounts := self readCountsFromFile: (aFileReference / self ngramCountsFileName).
	vocabulary := self readVocabularyFromFile: (aFileReference / self vocabularyFileName).
	
	order := ngramCounts anyOne order.
	
	^ (self order: order)
		initializeHistoryCounts: historyCounts
		ngramCounts: ngramCounts
		vocabulary: vocabulary
]

{ #category : #'file in/out' }
NgramModel class >> readVocabularyFromFile: aFileReference [
	| vocabulary stream |
	vocabulary := Set new.
	stream := aFileReference readStream.
	
	[stream atEnd] whileFalse: [
		vocabulary add: stream nextLine ].
	
	stream close.
	^ vocabulary
]

{ #category : #'file in/out' }
NgramModel class >> vocabularyFileName [
	^ 'vocabulary.csv'
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
NgramModel >> initializeHistoryCounts: aHistoryTable ngramCounts: anNgramTable vocabulary: aVocabulary [
	historyCounts := aHistoryTable.
	ngramCounts := anNgramTable.
	vocabulary := aVocabulary.
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

{ #category : #'file in/out' }
NgramModel >> saveCounts: aDictionary toFile: aFileReference [
	| stream ngramString countString |
	stream := aFileReference writeStream.
	
	aDictionary associationsDo: [ :each |
		ngramString := ' ' join: each key asArray.
		countString := each value asString.
		
		stream
			nextPutAll: ngramString;
			nextPutAll: ',';
			nextPutAll: countString;
			cr ].
		
	stream close
]

{ #category : #'file in/out' }
NgramModel >> saveToDirectory: aDirectory [
	self saveCounts: ngramCounts toFile: aDirectory / self class ngramCountsFileName.
	self saveCounts: historyCounts toFile: aDirectory / self class historyCountsFileName.
	self saveVocabularyToFile: aDirectory / self class vocabularyFileName
]

{ #category : #'file in/out' }
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
