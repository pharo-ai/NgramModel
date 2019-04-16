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
	ngram := Ngram with: 'lorem' with: 'ipsum'. 
	
	self assert: ngram order equals: 2.
]

{ #category : #tests }
NgramTest >> testEquality [
	| firstNgram secondNgram |
	firstNgram := Ngram with: 'lorem' with: 'ipsum' with: 'dolor'.
	secondNgram :=  Ngram with: 'lorem' with: 'ipsum' with: 'dolor'.
	
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
	firstNgram := Ngram with: 'lorem' with: 'ipsum'.
	secondNgram :=  Ngram with: 'lorem' with: 'ipsum' with: 'dolor'.
	
	self deny: firstNgram equals: secondNgram.
	self deny: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
NgramTest >> testInequalityValues [
	| firstNgram secondNgram |
	firstNgram := Ngram with: 'lorem' with: 'dolor' with: 'dolor'.
	secondNgram :=  Ngram with: 'lorem' with: 'ipsum' with: 'dolor'.
	
	self deny: firstNgram equals: secondNgram.
	self deny: firstNgram hash equals: secondNgram hash.
]

{ #category : #tests }
NgramTest >> testPentagramHasOrder5 [
	| ngram |
	ngram := Ngram with: 'lorem' with: 'ipsum' with: 'dolor' with: 'sit' with: 'amet'. 
	
	self assert: ngram order equals: 5.
]

{ #category : #tests }
NgramTest >> testTetragramHasOrder4 [
	| ngram |
	ngram := Ngram with: 'lorem' with: 'ipsum' with: 'dolor' with: 'sit'. 
	
	self assert: ngram order equals: 4.
]

{ #category : #tests }
NgramTest >> testTrigramHasOrder3 [
	| ngram |
	ngram := Ngram with: 'lorem' with: 'ipsum' with: 'dolor'. 
	
	self assert: ngram order equals: 3.
]

{ #category : #tests }
NgramTest >> testTrigramHistory [
	| ngram |
	ngram := Ngram with: 'lorem' with: 'ipsum' with: 'dolor'. 
	
	self assert: ngram history equals: #(lorem ipsum) asNgram.
]

{ #category : #tests }
NgramTest >> testTrigramLast [
	| ngram |
	ngram := Ngram with: 'lorem' with: 'ipsum' with: 'dolor'. 
	
	self assert: ngram last equals: 'dolor'.
]

{ #category : #tests }
NgramTest >> testUnigramHasOrder1 [
	| ngram |
	ngram := Ngram with: 'lorem'. 
	
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
