Class {
	#name : #NgramSequenceableCollectionTest,
	#superclass : #TestCase,
	#instVars : [
		'collection'
	],
	#category : #'Ngram-Tests'
}

{ #category : #running }
NgramSequenceableCollectionTest >> setUp [ 
	super setUp.
	collection := #(I do not like green eggs and ham).
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testAsNgram [
	| ngram |
	ngram := collection asNgram.
	self assert: ngram order equals: 8.
	self assert: ngram history equals: #(I do not like green eggs and) asNgram.
	self assert: ngram last equals: 'ham'.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testBigrams [
	| expected actual |
	
	expected := {
		#(I do) asNgram .
		#(do not) asNgram .
		#(not like) asNgram .
		#(like green) asNgram .
		#(green eggs) asNgram .
		#(eggs and) asNgram .
		#(and ham) asNgram }.
	
	actual := collection bigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testBigramsPadWith [
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
		
	actual := collection bigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testBigramsWithDefaultPadding [
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
		
	actual := collection bigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testNgrams [
	| expected actual |
	
	expected := {
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram }.
	
	actual := collection ngrams: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testNgramsPadWith [
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
		
	actual := collection ngrams: 3 padWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testNgramsWithDefaultPadding [
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
		
	actual := collection ngramsWithDefaultPadding: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testPentagrams [
	| expected actual |
	
	expected := {
		#(I do not like green) asNgram .
		#(do not like green eggs) asNgram .
		#(not like green eggs and) asNgram .
		#(like green eggs and ham) asNgram }.
	
	actual := collection pentagrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testPentagramsPadWith [
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
		
	actual := collection pentagramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testPentagramsWithDefaultPadding [
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
		
	actual := collection pentagramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testTetragrams [
	| expected actual |
	
	expected := {
		#(I do not like) asNgram .
		#(do not like green) asNgram .
		#(not like green eggs) asNgram .
		#(like green eggs and) asNgram .
		#(green eggs and ham) asNgram }.
	
	actual := collection tetragrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testTetragramsPadWith [
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
		
	actual := collection tetragramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testTetragramsWithDefaultPadding [
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
		
	actual := collection tetragramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testTrigrams [
	| expected actual |
	
	expected := {
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram }.
	
	actual := collection trigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testTrigramsPadWith [
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
		
	actual := collection trigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testTrigramsWithDefaultPadding [
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
		
	actual := collection trigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testUnigrams [
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
	
	actual := collection unigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testUnigramsPadWith [
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
	
	actual := collection unigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramSequenceableCollectionTest >> testUnigramsWithDefaultPadding [
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
	
	actual := collection unigramsWithDefaultPadding.
	self assert: actual equals: expected.
]
