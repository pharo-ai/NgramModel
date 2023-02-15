Extension { #name : #String }

{ #category : #'*Ngram' }
String >> asNgram [
	^ Ngram withElements: { self }
]

{ #category : #'*Ngram' }
String >> ngrams: order [
	^ self tokenizeForNgrams ngrams: order
]

{ #category : #'*Ngram' }
String >> ngrams: order padWith: padSymbol [
	^ self tokenizeForNgrams ngrams: order padWith: padSymbol
]

{ #category : #'*Ngram' }
String >> tokenizeForNgrams [
	^ ' ' split: self
]
