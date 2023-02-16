Class {
	#name : #AINgramTest,
	#superclass : #TestCase,
	#category : #'AI-Ngram-Tests'
}

{ #category : #tests }
AINgramTest >> testAsArray [
	| ngram expected actual |
	ngram := #(1 2 3) asNgram.
	expected := #(1 2 3).
	actual := ngram asArray.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramTest >> testEquality [
	| firstNgram secondNgram |
	firstNgram := #(lorem ipsum dolor) asNgram.
	secondNgram :=  #(lorem ipsum dolor) asNgram.
	
	self assert: firstNgram equals: secondNgram.
	self assert: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
AINgramTest >> testHistory [
	| ngram |
	ngram := #(lorem ipsum dolor) asNgram. 
	self assert: ngram history equals: #(lorem ipsum) asNgram.
]

{ #category : #tests }
AINgramTest >> testInequalitySize [
	| firstNgram secondNgram |
	firstNgram := #(lorem ipsum) asNgram.
	secondNgram :=  #(lorem ipsum dolor) asNgram.
	
	self deny: firstNgram equals: secondNgram.
	self deny: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
AINgramTest >> testInequalityValues [
	| firstNgram secondNgram |
	firstNgram := #(lorem dolor dolor) asNgram.
	secondNgram :=  #(lorem ipsum dolor) asNgram.
	
	self deny: firstNgram equals: secondNgram.
	self deny: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
AINgramTest >> testLast [
	| ngram |
	ngram := #(lorem ipsum dolor) asNgram. 
	self assert: ngram last equals: 'dolor'.
]

{ #category : #tests }
AINgramTest >> testOrder [
	| ngram |
	ngram := #(lorem ipsum dolor sit) asNgram. 
	self assert: ngram order equals: 4.
]

{ #category : #tests }
AINgramTest >> testPrintOn [
	| ngram stream expected actual |
	
	ngram := #(hello world) asNgram.
	stream := String new writeStream.
	ngram printOn: stream.
	
	expected := 'n-gram(hello world)'.
	actual := stream contents.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramTest >> testWithElements [
	| ngram |
	ngram := AINgram withElements: #(1 2 3).
	self assert: ngram order equals: 3.
]

{ #category : #tests }
AINgramTest >> testWithElementsEmptyArray [
	| ngram |
	ngram := AINgram withElements: #().
	self assert: ngram order equals: 0.
]

{ #category : #tests }
AINgramTest >> testWithHistoryLast [
	| expected actual |
	expected := #(1 2 3) asNgram.
	actual := AINgram withHistory: #(1 2) asNgram last: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramTest >> testZerogram [
	| ngram |
	ngram := AINgram zerogram. 
	self assert: ngram order equals: 0.
	self assert: ngram history isEmpty.
	self assert: ngram last isNil.
]
