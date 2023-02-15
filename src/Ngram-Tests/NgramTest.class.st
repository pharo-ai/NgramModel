Class {
	#name : #NgramTest,
	#superclass : #TestCase,
	#category : #'Ngram-Tests'
}

{ #category : #tests }
NgramTest >> testAsArray [
	| ngram expected actual |
	ngram := #(1 2 3) asNgram.
	expected := #(1 2 3).
	actual := ngram asArray.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramTest >> testEquality [
	| firstNgram secondNgram |
	firstNgram := #(lorem ipsum dolor) asNgram.
	secondNgram :=  #(lorem ipsum dolor) asNgram.
	
	self assert: firstNgram equals: secondNgram.
	self assert: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
NgramTest >> testHistory [
	| ngram |
	ngram := #(lorem ipsum dolor) asNgram. 
	self assert: ngram history equals: #(lorem ipsum) asNgram.
]

{ #category : #tests }
NgramTest >> testInequalitySize [
	| firstNgram secondNgram |
	firstNgram := #(lorem ipsum) asNgram.
	secondNgram :=  #(lorem ipsum dolor) asNgram.
	
	self deny: firstNgram equals: secondNgram.
	self deny: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
NgramTest >> testInequalityValues [
	| firstNgram secondNgram |
	firstNgram := #(lorem dolor dolor) asNgram.
	secondNgram :=  #(lorem ipsum dolor) asNgram.
	
	self deny: firstNgram equals: secondNgram.
	self deny: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
NgramTest >> testLast [
	| ngram |
	ngram := #(lorem ipsum dolor) asNgram. 
	self assert: ngram last equals: 'dolor'.
]

{ #category : #tests }
NgramTest >> testOrder [
	| ngram |
	ngram := #(lorem ipsum dolor sit) asNgram. 
	self assert: ngram order equals: 4.
]

{ #category : #tests }
NgramTest >> testPrintOn [
	| ngram stream expected actual |
	
	ngram := #(hello world) asNgram.
	stream := String new writeStream.
	ngram printOn: stream.
	
	expected := 'n-gram(hello world)'.
	actual := stream contents.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramTest >> testWithElements [
	| ngram |
	ngram := Ngram withElements: #(1 2 3).
	self assert: ngram order equals: 3.
]

{ #category : #tests }
NgramTest >> testWithElementsEmptyArray [
	| ngram |
	ngram := Ngram withElements: #().
	self assert: ngram order equals: 0.
]

{ #category : #tests }
NgramTest >> testWithHistoryLast [
	| expected actual |
	expected := #(1 2 3) asNgram.
	actual := Ngram withHistory: #(1 2) asNgram last: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramTest >> testZerogram [
	| ngram |
	ngram := Ngram zerogram. 
	self assert: ngram order equals: 0.
	self assert: ngram history isEmpty.
	self assert: ngram last isNil.
]
