Extension { #name : #SequenceableCollection }

{ #category : #'*AI-Ngram' }
SequenceableCollection >> asNgram [
	^ AINgram withElements: self
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> bigrams [ 
	^ self ngrams: 2
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> bigramsPadWith: padSymbol [
	^ self ngrams: 2 padWith: padSymbol
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> bigramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 2
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> defaultNgramPadding [
	^ '<s>'
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> ngrams: order [
	^ (1 to: self size - order + 1) collect: [ :i |
		(self copyFrom: i to: i + order - 1) asNgram ]
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> ngrams: order padWith: padSymbol [
	| elements |
	elements := self asOrderedCollection.
	
	(order - 1) timesRepeat: [
		elements addFirst: padSymbol.
		elements addLast: padSymbol ].
	
	^ elements ngrams: order.
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> ngramsWithDefaultPadding: order [
	^ self ngrams: order padWith: self defaultNgramPadding.
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> pentagrams [ 
	^ self ngrams: 5
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> pentagramsPadWith: padSymbol [
	^ self ngrams: 5 padWith: padSymbol
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> pentagramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 5
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> tetragrams [ 
	^ self ngrams: 4
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> tetragramsPadWith: padSymbol [
	^ self ngrams: 4 padWith: padSymbol
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> tetragramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 4
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> trigrams [ 
	^ self ngrams: 3
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> trigramsPadWith: padSymbol [
	^ self ngrams: 3 padWith: padSymbol
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> trigramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 3
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> unigrams [ 
	^ self ngrams: 1
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> unigramsPadWith: padSymbol [
	^ self ngrams: 1 padWith: padSymbol
]

{ #category : #'*AI-Ngram' }
SequenceableCollection >> unigramsWithDefaultPadding [
	^ self ngramsWithDefaultPadding: 1
]
