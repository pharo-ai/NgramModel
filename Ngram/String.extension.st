Extension { #name : #String }

{ #category : #'*Ngram' }
String >> bigrams [
	^ self ngrams: 2.
]

{ #category : #'*Ngram' }
String >> bigramsPad: padSymbol [
	^ self ngrams: 2 pad: padSymbol
]

{ #category : #'*Ngram' }
String >> ngrams: order [
	^ self ngramsNoPad: order.
]

{ #category : #'*Ngram' }
String >> ngrams: order pad: padSymbol [
	| tokens |
	tokens := self findTokens: ' '.
	self padTokens: tokens with: padSymbol order: order.
	^ self tokens: tokens toNgrams: order
]

{ #category : #'*Ngram' }
String >> ngramsNoPad: order [
	| tokens |
	tokens := self findTokens: ' '.
	
	^ self tokens: tokens toNgrams: order
]

{ #category : #'*Ngram' }
String >> padTokens: tokens with: padSymbol order: order [
	(order - 1) timesRepeat: [
		tokens addFirst: padSymbol.
		tokens addLast: padSymbol ]
]

{ #category : #'*Ngram' }
String >> pentagrams [
	^ self ngrams: 5.
]

{ #category : #'*Ngram' }
String >> pentagramsPad: padSymbol [
	^ self ngrams: 5 pad: padSymbol
]

{ #category : #'*Ngram' }
String >> tetragrams [
	^ self ngrams: 4.
]

{ #category : #'*Ngram' }
String >> tetragramsPad: padSymbol [
	^ self ngrams: 4 pad: padSymbol
]

{ #category : #'*Ngram' }
String >> tokens: tokens toNgrams: order [
	^ (1 to: tokens size - order + 1) collect: [ :i |
		(tokens copyFrom: i to: i + order - 1) asArray asNgram ]
]

{ #category : #'*Ngram' }
String >> trigrams [
	^ self ngrams: 3.
]

{ #category : #'*Ngram' }
String >> trigramsPad: padSymbol [
	^ self ngrams: 3 pad: padSymbol
]

{ #category : #'*Ngram' }
String >> unigrams [
	^ self ngrams: 1.
]

{ #category : #'*Ngram' }
String >> unigramsPad: padSymbol [
	^ self ngrams: 1 pad: padSymbol
]
