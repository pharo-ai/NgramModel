Class {
	#name : #NgramTest,
	#superclass : #TestCase,
	#category : #'Ngram-Tests'
}

{ #category : #tests }
NgramTest >> testAsNgram [
	| ngram |
	ngram := #(1 2 3) asNgram.
	
	self assert: ngram order equals: 3.
]

{ #category : #tests }
NgramTest >> testBigramHasOrder2 [
	| ngram |
	ngram := #(lorem ipsum) asNgram. 
	self assert: ngram order equals: 2.
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
NgramTest >> testFromArray [
	| ngram |
	ngram := Ngram fromArray: #(1 2 3).
	
	self assert: ngram order equals: 3.
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
NgramTest >> testPentagramHasOrder5 [
	| ngram |
	ngram := #(lorem ipsum dolor sit amet) asNgram. 
	self assert: ngram order equals: 5.
]

{ #category : #tests }
NgramTest >> testTetragramHasOrder4 [
	| ngram |
	ngram := #(lorem ipsum dolor sit) asNgram. 
	self assert: ngram order equals: 4.
]

{ #category : #tests }
NgramTest >> testTrigramHasOrder3 [
	| ngram |
	ngram := #(lorem ipsum dolor) asNgram. 
	self assert: ngram order equals: 3.
]

{ #category : #tests }
NgramTest >> testTrigramHistory [
	| ngram |
	ngram := #(lorem ipsum dolor) asNgram. 
	self assert: ngram history equals: #(lorem ipsum) asNgram.
]

{ #category : #tests }
NgramTest >> testTrigramLast [
	| ngram |
	ngram := #(lorem ipsum dolor) asNgram. 
	self assert: ngram last equals: 'dolor'.
]

{ #category : #tests }
NgramTest >> testUnigramHasOrder1 [
	| ngram |
	ngram := #(lorem) asNgram. 
	self assert: ngram order equals: 1.
]

{ #category : #tests }
NgramTest >> testZerogramFromArray [
	| ngram |
	ngram := Ngram fromArray: #().
	
	self assert: ngram order equals: 0.
]

{ #category : #tests }
NgramTest >> testZerogramHasOrder0 [
	| ngram |
	ngram := Ngram zerogram. 
	self assert: ngram order equals: 0.
]
