Class {
	#name : #NgramStringTest,
	#superclass : #TestCase,
	#category : #'Ngram-Tests'
}

{ #category : #tests }
NgramStringTest >> testBigrams [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text bigrams.
	expected := #((Lorem ipsum) (ipsum dolor) (dolor sit) (sit amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testBigramsPad [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text bigramsPad: '<s>'.
	expected := #(('<s>' Lorem) (Lorem ipsum) (ipsum dolor) (dolor sit) (sit amet) (amet '<s>')) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder1 [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 1.
	expected := #((Lorem) (ipsum) (dolor) (sit) (amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder1Pad [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 1 pad: '<s>'.
	expected := #((Lorem) (ipsum) (dolor) (sit) (amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder2 [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 2.
	expected := #((Lorem ipsum) (ipsum dolor) (dolor sit) (sit amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder2Pad [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 2 pad: '<s>'.
	expected := #(('<s>' Lorem) (Lorem ipsum) (ipsum dolor) (dolor sit) (sit amet) (amet '<s>')) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder3 [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 3.
	expected := #((Lorem ipsum dolor) (ipsum dolor sit) (dolor sit amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder3Pad [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 3 pad: '<s>'.
	expected := #(('<s>' '<s>' Lorem) ('<s>' Lorem ipsum) (Lorem ipsum dolor) (ipsum dolor sit) (dolor sit amet) (sit amet '<s>') (amet '<s>' '<s>')) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder4 [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 4.
	expected := #((Lorem ipsum dolor sit) (ipsum dolor sit amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder4Pad [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 4 pad: '<s>'.
	expected := #(('<s>' '<s>' '<s>' Lorem) ('<s>' '<s>' Lorem ipsum) ('<s>' Lorem ipsum dolor) (Lorem ipsum dolor sit) (ipsum dolor sit amet) (dolor sit amet '<s>') (sit amet '<s>' '<s>') (amet '<s>' '<s>' '<s>')) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder5 [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 5.
	expected := #((Lorem ipsum dolor sit amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder5Pad [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 5 pad: '<s>'.
	expected := #(('<s>' '<s>' '<s>' '<s>' Lorem) ('<s>' '<s>' '<s>' Lorem ipsum) ('<s>' '<s>' Lorem ipsum dolor) ('<s>' Lorem ipsum dolor sit) (Lorem ipsum dolor sit amet) (ipsum dolor sit amet '<s>') (dolor sit amet '<s>' '<s>') (sit amet '<s>' '<s>' '<s>') (amet '<s>' '<s>' '<s>' '<s>')) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testNgramsOrder6 [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text ngrams: 6.
	expected := Array new.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testPentagrams [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text pentagrams.
	expected := #((Lorem ipsum dolor sit amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testPentagramsPad [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text pentagramsPad: '<s>'.
	expected := #(('<s>' '<s>' '<s>' '<s>' Lorem) ('<s>' '<s>' '<s>' Lorem ipsum) ('<s>' '<s>' Lorem ipsum dolor) ('<s>' Lorem ipsum dolor sit) (Lorem ipsum dolor sit amet) (ipsum dolor sit amet '<s>') (dolor sit amet '<s>' '<s>') (sit amet '<s>' '<s>' '<s>') (amet '<s>' '<s>' '<s>' '<s>')) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testTetragrams [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text tetragrams.
	expected := #((Lorem ipsum dolor sit) (ipsum dolor sit amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testTetragramsPad [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text tetragramsPad: '<s>'.
	expected := #(('<s>' '<s>' '<s>' Lorem) ('<s>' '<s>' Lorem ipsum) ('<s>' Lorem ipsum dolor) (Lorem ipsum dolor sit) (ipsum dolor sit amet) (dolor sit amet '<s>') (sit amet '<s>' '<s>') (amet '<s>' '<s>' '<s>')) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testTrigrams [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text trigrams.
	expected := #((Lorem ipsum dolor) (ipsum dolor sit) (dolor sit amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testTrigramsPad [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text trigramsPad: '<s>'.
	expected := #(('<s>' '<s>' Lorem) ('<s>' Lorem ipsum) (Lorem ipsum dolor) (ipsum dolor sit) (dolor sit amet) (sit amet '<s>') (amet '<s>' '<s>')) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testUnigrams [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text unigrams.
	expected := #((Lorem) (ipsum) (dolor) (sit) (amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]

{ #category : #tests }
NgramStringTest >> testUnigramsPad [
	| text ngrams expected |
	text := 'Lorem ipsum dolor sit amet'.
	ngrams := text unigramsPad: '<s>'.
	expected := #((Lorem) (ipsum) (dolor) (sit) (amet)) collect: #asNgram.
	self assert: ngrams equals: expected.
]
