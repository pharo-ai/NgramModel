Extension { #name : #SequenceableCollection }

{ #category : #'*Ngram' }
SequenceableCollection >> asNgram [
	^ Ngram withElements: self
]

{ #category : #'*Ngram' }
SequenceableCollection >> bigrams [ 
	^ self ngrams: 2
]

{ #category : #'*Ngram' }
SequenceableCollection >> bigramsPadWith: padSymbol [
	^ self ngrams: 2 padWith: padSymbol
]

{ #category : #'*Ngram' }
SequenceableCollection >> bigramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 2
]

{ #category : #'*Ngram' }
SequenceableCollection >> defaultNgramPadding [
	^ '<s>'
]

{ #category : #'*Ngram' }
SequenceableCollection >> ngrams: order [
	^ (1 to: self size - order + 1) collect: [ :i |
		(self copyFrom: i to: i + order - 1) asNgram ]
]

{ #category : #'*Ngram' }
SequenceableCollection >> ngrams: order padWith: padSymbol [
	| elements |
	elements := self asOrderedCollection.
	
	(order - 1) timesRepeat: [
		elements addFirst: padSymbol.
		elements addLast: padSymbol ].
	
	^ elements ngrams: order.
]

{ #category : #'*Ngram' }
SequenceableCollection >> ngramsWithDefaultPadding: order [
	^ self ngrams: order padWith: self defaultNgramPadding.
]

{ #category : #'*Ngram' }
SequenceableCollection >> pentagrams [ 
	^ self ngrams: 5
]

{ #category : #'*Ngram' }
SequenceableCollection >> pentagramsPadWith: padSymbol [
	^ self ngrams: 5 padWith: padSymbol
]

{ #category : #'*Ngram' }
SequenceableCollection >> pentagramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 5
]

{ #category : #'*Ngram' }
SequenceableCollection >> tetragrams [ 
	^ self ngrams: 4
]

{ #category : #'*Ngram' }
SequenceableCollection >> tetragramsPadWith: padSymbol [
	^ self ngrams: 4 padWith: padSymbol
]

{ #category : #'*Ngram' }
SequenceableCollection >> tetragramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 4
]

{ #category : #'*Ngram' }
SequenceableCollection >> trigrams [ 
	^ self ngrams: 3
]

{ #category : #'*Ngram' }
SequenceableCollection >> trigramsPadWith: padSymbol [
	^ self ngrams: 3 padWith: padSymbol
]

{ #category : #'*Ngram' }
SequenceableCollection >> trigramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 3
]

{ #category : #'*Ngram' }
SequenceableCollection >> unigrams [ 
	^ self ngrams: 1
]

{ #category : #'*Ngram' }
SequenceableCollection >> unigramsPadWith: padSymbol [
	^ self ngrams: 1 padWith: padSymbol
]

{ #category : #'*Ngram' }
SequenceableCollection >> unigramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 1
]
