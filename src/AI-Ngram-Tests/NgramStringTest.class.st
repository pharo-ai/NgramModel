Class {
	#name : #NgramStringTest,
	#superclass : #TestCase,
	#instVars : [
		'text'
	],
	#category : #'AI-Ngram-Tests'
}

{ #category : #running }
NgramStringTest >> setUp [ 	
	super setUp.
	text := 'I do not like green eggs and ham'.
]

{ #category : #tests }
NgramStringTest >> testAsNgram [
	| str expected actual |
	str := 'hello'.
	expected := #(hello) asNgram.
	actual := str asNgram.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testBigrams [
	| expected actual |
	
	expected := {
		#(I do) asNgram .
		#(do not) asNgram .
		#(not like) asNgram .
		#(like green) asNgram .
		#(green eggs) asNgram .
		#(eggs and) asNgram .
		#(and ham) asNgram }.
	
	actual := text bigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testBigramsPadWith [
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
		
	actual := text bigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testBigramsWithDefaultPadding [
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
		
	actual := text bigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgrams [
	| expected actual |
	
	expected := {
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram }.
	
	actual := text ngrams: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsPadWith [
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
		
	actual := text ngrams: 3 padWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsWithDefaultPadding [
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
		
	actual := text ngramsWithDefaultPadding: 3.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testPentagrams [
	| expected actual |
	
	expected := {
		#(I do not like green) asNgram .
		#(do not like green eggs) asNgram .
		#(not like green eggs and) asNgram .
		#(like green eggs and ham) asNgram }.
	
	actual := text pentagrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testPentagramsPadWith [
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
		
	actual := text pentagramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testPentagramsWithDefaultPadding [
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
		
	actual := text pentagramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testTetragrams [
	| expected actual |
	
	expected := {
		#(I do not like) asNgram .
		#(do not like green) asNgram .
		#(not like green eggs) asNgram .
		#(like green eggs and) asNgram .
		#(green eggs and ham) asNgram }.
	
	actual := text tetragrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testTetragramsPadWith [
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
		
	actual := text tetragramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testTetragramsWithDefaultPadding [
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
		
	actual := text tetragramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testTrigrams [
	| expected actual |
	
	expected := {
		#(I do not) asNgram .
		#(do not like) asNgram .
		#(not like green) asNgram .
		#(like green eggs) asNgram .
		#(green eggs and) asNgram .
		#(eggs and ham) asNgram }.
	
	actual := text trigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testTrigramsPadWith [
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
		
	actual := text trigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testTrigramsWithDefaultPadding [
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
		
	actual := text trigramsWithDefaultPadding.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testUnigrams [
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
	
	actual := text unigrams.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testUnigramsPadWith [
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
	
	actual := text unigramsPadWith: '##'.
	self assert: actual equals: expected.
]

{ #category : #tests }
NgramStringTest >> testUnigramsWithDefaultPadding [
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
	
	actual := text unigramsWithDefaultPadding.
	self assert: actual equals: expected.
]
