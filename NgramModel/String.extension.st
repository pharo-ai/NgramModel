Extension { #name : #String }

{ #category : #'*NgramModel' }
String >> bigrams [
	^ self ngrams: 2.
]

{ #category : #'*NgramModel' }
String >> bigramsPad: padSymbol [
	^ self ngrams: 2 pad: padSymbol
]

{ #category : #'*NgramModel' }
String >> ngrams: order [
	^ self ngramsNoPad: order.
]

{ #category : #'*NgramModel' }
String >> ngrams: order pad: padSymbol [
	| tokens |
	tokens := self findTokens: ' '.
	self padTokens: tokens with: padSymbol order: order.
	^ self tokens: tokens toNgrams: order
]

{ #category : #'*NgramModel' }
String >> ngramsNoPad: order [
	| tokens |
	tokens := self findTokens: ' '.
	
	^ self tokens: tokens toNgrams: order
]

{ #category : #'*NgramModel' }
String >> padTokens: tokens with: padSymbol order: order [
	(order - 1) timesRepeat: [
		tokens addFirst: padSymbol.
		tokens addLast: padSymbol ]
]

{ #category : #'*NgramModel' }
String >> pentagrams [
	^ self ngrams: 5.
]

{ #category : #'*NgramModel' }
String >> pentagramsPad: padSymbol [
	^ self ngrams: 5 pad: padSymbol
]

{ #category : #'*NgramModel' }
String >> tetragrams [
	^ self ngrams: 4.
]

{ #category : #'*NgramModel' }
String >> tetragramsPad: padSymbol [
	^ self ngrams: 4 pad: padSymbol
]

{ #category : #'*NgramModel' }
String >> tokens: tokens toNgrams: order [
	^ (1 to: tokens size - order + 1) collect: [ :i |
		(tokens copyFrom: i to: i + order - 1) asArray asNgram ]
]

{ #category : #'*NgramModel' }
String >> trigrams [
	^ self ngrams: 3.
]

{ #category : #'*NgramModel' }
String >> trigramsPad: padSymbol [
	^ self ngrams: 3 pad: padSymbol
]

{ #category : #'*NgramModel' }
String >> unigrams [
	^ self ngrams: 1.
]

{ #category : #'*NgramModel' }
String >> unigramsPad: padSymbol [
	^ self ngrams: 1 pad: padSymbol
]
