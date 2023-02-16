Class {
	#name : #AINgramSequenceableCollectionTest,
	#superclass : #TestCase,
	#category : #'AI-Ngram-Tests'
}

{ #category : #accessing }
AINgramSequenceableCollectionTest >> collection [

	^ #( I do not like green eggs and ham )
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testAsNgram [
	| ngram |
	ngram := self collection asNgram.
	self assert: ngram order equals: 8.
	self assert: ngram history equals: #(I do not like green eggs and) asNgram.
	self assert: ngram last equals: 'ham'.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testBigrams [
	| expected actual |
	
	expected := {
		#(I do) asNgram .
		#(do not) asNgram .
		#(not like) asNgram .
		#(like green) asNgram .
		#(green eggs) asNgram .
		#(eggs and) asNgram .
		#(and ham) asNgram }.
	
	actual := self collection bigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testBigramsPadWith [
	| expected actual |
	
	expected := {
		#('##' I) asNgram .
		#(I do) asNgram .
		#(do not) asNgram .
		#(not like) asNgram .
		#(like green) asNgram .
		#(green eggs) asNgram .
		#(eggs and) asNgram .
		#(and ham) asNgram .
		#(ham '##') asNgram }.
		
	actual := self collection bigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testBigramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#('<s>' I) asNgram .
		#(I do) asNgram .
		#(do not) asNgram .
		#(not like) asNgram .
		#(like green) asNgram .
		#(green eggs) asNgram .
		#(eggs and) asNgram .
		#(and ham) asNgram .
		#(ham '<s>') asNgram }.
		
	actual := self collection bigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testNgrams [
	| expected actual |
	
	expected := {
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram }.
	
	actual := self collection ngrams: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testNgramsPadWith [
	| expected actual |
	
	expected := {
		#('##' '##' I) asNgram .
		#('##' I do) asNgram .
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram .
		#(and ham '##') asNgram .
		#(ham '##' '##') asNgram }.
		
	actual := self collection ngrams: 3 padWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testNgramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#('<s>' '<s>' I) asNgram .
		#('<s>' I do) asNgram .
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram .
		#(and ham '<s>') asNgram .
		#(ham '<s>' '<s>') asNgram }.
		
	actual := self collection ngramsWithDefaultPadding: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testPentagrams [
	| expected actual |
	
	expected := {
		#(I do not like green) asNgram .
		#(do not like green eggs) asNgram .
		#(not like green eggs and) asNgram .
		#(like green eggs and ham) asNgram }.
	
	actual := self collection pentagrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testPentagramsPadWith [
	| expected actual |
	
	expected := {
		#('##' '##' '##' '##' I) asNgram .
		#('##' '##' '##' I do) asNgram .
		#('##' '##' I do not) asNgram .
		#('##' I do not like) asNgram .
		#(I do not like green) asNgram .
		#(do not like green eggs) asNgram .
		#(not like green eggs and) asNgram .
		#(like green eggs and ham) asNgram .
		#(green eggs and ham '##') asNgram .
		#(eggs and ham '##' '##') asNgram .
		#(and ham '##' '##' '##') asNgram .
		#(ham '##' '##' '##' '##') asNgram }.
		
	actual := self collection pentagramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testPentagramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#('<s>' '<s>' '<s>' '<s>' I) asNgram .
		#('<s>' '<s>' '<s>' I do) asNgram .
		#('<s>' '<s>' I do not) asNgram .
		#('<s>' I do not like) asNgram .
		#(I do not like green) asNgram .
		#(do not like green eggs) asNgram .
		#(not like green eggs and) asNgram .
		#(like green eggs and ham) asNgram .
		#(green eggs and ham '<s>') asNgram .
		#(eggs and ham '<s>' '<s>') asNgram .
		#(and ham '<s>' '<s>' '<s>') asNgram .
		#(ham '<s>' '<s>' '<s>' '<s>') asNgram }.
		
	actual := self collection pentagramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTetragrams [
	| expected actual |
	
	expected := {
		#(I do not like) asNgram .
		#(do not like green) asNgram .
		#(not like green eggs) asNgram .
		#(like green eggs and) asNgram .
		#(green eggs and ham) asNgram }.
	
	actual := self collection tetragrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTetragramsPadWith [
	| expected actual |
	
	expected := {
		#('##' '##' '##' I) asNgram .
		#('##' '##' I do) asNgram .
		#('##' I do not) asNgram .
		#(I do not like) asNgram .
		#(do not like green) asNgram .
		#(not like green eggs) asNgram .
		#(like green eggs and) asNgram .
		#(green eggs and ham) asNgram .
		#(eggs and ham '##') asNgram .
		#(and ham '##' '##') asNgram .
		#(ham '##' '##' '##') asNgram }.
		
	actual := self collection tetragramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTetragramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#('<s>' '<s>' '<s>' I) asNgram .
		#('<s>' '<s>' I do) asNgram .
		#('<s>' I do not) asNgram .
		#(I do not like) asNgram .
		#(do not like green) asNgram .
		#(not like green eggs) asNgram .
		#(like green eggs and) asNgram .
		#(green eggs and ham) asNgram .
		#(eggs and ham '<s>') asNgram .
		#(and ham '<s>' '<s>') asNgram .
		#(ham '<s>' '<s>' '<s>') asNgram }.
		
	actual := self collection tetragramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTrigrams [
	| expected actual |
	
	expected := {
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram }.
	
	actual := self collection trigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTrigramsPadWith [
	| expected actual |
	
	expected := {
		#('##' '##' I) asNgram .
		#('##' I do) asNgram .
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram .
		#(and ham '##') asNgram .
		#(ham '##' '##') asNgram }.
		
	actual := self collection trigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testTrigramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#('<s>' '<s>' I) asNgram .
		#('<s>' I do) asNgram .
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram .
		#(and ham '<s>') asNgram .
		#(ham '<s>' '<s>') asNgram }.
		
	actual := self collection trigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testUnigrams [
	| expected actual |
	
	expected := {
		#(I) asNgram .
		#(do) asNgram .
		#(not) asNgram .
		#(like) asNgram .
		#(green) asNgram .
		#(eggs) asNgram .
		#(and) asNgram .
		#(ham) asNgram }.
	
	actual := self collection unigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testUnigramsPadWith [
	| expected actual |
	
	expected := {
		#(I) asNgram .
		#(do) asNgram .
		#(not) asNgram .
		#(like) asNgram .
		#(green) asNgram .
		#(eggs) asNgram .
		#(and) asNgram .
		#(ham) asNgram }.
	
	actual := self collection unigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramSequenceableCollectionTest >> testUnigramsWithDefaultPadding [
	| expected actual |
	
	expected := {
		#(I) asNgram .
		#(do) asNgram .
		#(not) asNgram .
		#(like) asNgram .
		#(green) asNgram .
		#(eggs) asNgram .
		#(and) asNgram .
		#(ham) asNgram }.
	
	actual := self collection unigramsWithDefaultPadding.
	self assert: actual equals: expected.
]
