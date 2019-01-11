Extension { #name : #Array }

{ #category : #'*NgramModel' }
Array >> asNgram [
	^ Ngram fromArray: self
]
