Class {
	#name : #AINgramStringTest,
	#superclass : #TestCase,
	#category : #'AI-Ngram-Tests'
}

{ #category : #tests }
AINgramStringTest >> testAsNgram [
	| str expected actual |
	str := 'hello'.
	expected := #(hello) asNgram.
	actual := str asNgram.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testBigrams [
	| expected actual |
	
	expected := {
		#(I do) asNgram .
		#(do not) asNgram .
		#(not like) asNgram .
		#(like green) asNgram .
		#(green eggs) asNgram .
		#(eggs and) asNgram .
		#(and ham) asNgram }.
	
	actual := self text bigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testBigramsPadWith [
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
		
	actual := self text bigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testBigramsWithDefaultPadding [
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
		
	actual := self text bigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testNgrams [
	| expected actual |
	
	expected := {
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram }.
	
	actual := self text ngrams: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testNgramsPadWith [
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
		
	actual := self text ngrams: 3 padWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testNgramsWithDefaultPadding [
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
		
	actual := self text ngramsWithDefaultPadding: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testPentagrams [
	| expected actual |
	
	expected := {
		#(I do not like green) asNgram .
		#(do not like green eggs) asNgram .
		#(not like green eggs and) asNgram .
		#(like green eggs and ham) asNgram }.
	
	actual := self text pentagrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testPentagramsPadWith [
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
		
	actual := self text pentagramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testPentagramsWithDefaultPadding [
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
		
	actual := self text pentagramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTetragrams [
	| expected actual |
	
	expected := {
		#(I do not like) asNgram .
		#(do not like green) asNgram .
		#(not like green eggs) asNgram .
		#(like green eggs and) asNgram .
		#(green eggs and ham) asNgram }.
	
	actual := self text tetragrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTetragramsPadWith [
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
		
	actual := self text tetragramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTetragramsWithDefaultPadding [
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
		
	actual := self text tetragramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTrigrams [
	| expected actual |
	
	expected := {
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram }.
	
	actual := self text trigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTrigramsPadWith [
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
		
	actual := self text trigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testTrigramsWithDefaultPadding [
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
		
	actual := self text trigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testUnigrams [
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
	
	actual := self text unigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testUnigramsPadWith [
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
	
	actual := self text unigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
AINgramStringTest >> testUnigramsWithDefaultPadding [
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
	
	actual := self text unigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #helpers }
AINgramStringTest >> text [

	^ 'I do not like green eggs and ham'
]
