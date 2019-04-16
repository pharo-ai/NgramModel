Extension { #name : #Array }

{ #category : #'*Ngram' }
Array >> asNgram [
	^ Ngram fromArray: self
]
