Extension { #name : #String }

{ #category : #'*AI-Ngram' }
String >> asNgram [
	^ Ngram withElements: { self }
]

{ #category : #'*AI-Ngram' }
String >> ngrams: order [
	^ self tokenizeForNgrams ngrams: order
]

{ #category : #'*AI-Ngram' }
String >> ngrams: order padWith: padSymbol [
	^ self tokenizeForNgrams ngrams: order padWith: padSymbol
]

{ #category : #'*AI-Ngram' }
String >> tokenizeForNgrams [
	^ ' ' split: self
]
