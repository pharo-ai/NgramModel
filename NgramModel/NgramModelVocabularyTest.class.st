Class {
	#name : #NgramModelVocabularyTest,
	#superclass : #TestCase,
	#instVars : [
		'vocabulary',
		'words'
	],
	#category : #NgramModel
}

{ #category : #running }
NgramModelVocabularyTest >> setUp [ 
	vocabulary := NgramModelVocabulary new.
	vocabulary
		add: 'lorem';
		add: 'ipsum';
		add: 'lorem'.
		
	words := Set
		with: '<s>'
		with: '<unk>'
		with: 'lorem'
		with: 'ipsum'.
]

{ #category : #tests }
NgramModelVocabularyTest >> testAllBigrams [
	| smallVocabulary ngrams |
	
	smallVocabulary := NgramModelVocabulary new.
	smallVocabulary add: 'x'.
	
	ngrams := #(('<s>' '<unk>')('<s>' x)('<unk>' '<s>')('<unk>' '<unk>')('<unk>'  x)(x '<s>')(x '<unk>')(x x)) collect: #asNgram.
	
	ngrams := ngrams asSet.
	
	self assert: (smallVocabulary allNgramsOfOrder: 2) equals: ngrams.
]

{ #category : #tests }
NgramModelVocabularyTest >> testAllTrigrams [
	| smallVocabulary ngrams |
	
	smallVocabulary := NgramModelVocabulary new.
	smallVocabulary add: 'x'.
	
	ngrams := #(('<s>' '<s>' '<unk>')('<s>' '<s>' x)('<s>' '<unk>' '<s>')('<s>' '<unk>' '<unk>')('<s>' '<unk>' x)('<s>' x '<s>')('<s>' x '<unk>')('<s>' x x)('<unk>' '<s>' '<s>')('<unk>' '<s>' '<unk>')('<unk>' '<s>' x)('<unk>' '<unk>' '<s>')('<unk>' '<unk>' '<unk>')('<unk>' '<unk>' x)('<unk>' x '<s>')('<unk>' x '<unk>')('<unk>' x x)(x '<s>' '<s>')(x '<s>' '<unk>')(x '<s>' x)(x '<unk>' '<s>')(x '<unk>' '<unk>')(x '<unk>' x)(x x '<s>')(x x '<unk>')(x x x)) collect: #asNgram.
	
	ngrams := ngrams asSet.
	
	self assert: (smallVocabulary allNgramsOfOrder: 3) equals: ngrams.
]

{ #category : #tests }
NgramModelVocabularyTest >> testNewVocabularyIsNotEmpty [
	self assert: NgramModelVocabulary new isEmpty not.
]

{ #category : #tests }
NgramModelVocabularyTest >> testNewVocabularySizeIs2 [
	self assert: NgramModelVocabulary new size equals: 2.
]

{ #category : #tests }
NgramModelVocabularyTest >> testNumberOfReservedTokens [
	self assert: vocabulary numberOfReservedTokens equals: 2
]

{ #category : #tests }
NgramModelVocabularyTest >> testPadSymbol [
	self assert: vocabulary padSymbol equals: '<s>'
]

{ #category : #tests }
NgramModelVocabularyTest >> testUnknownSymbol [
	self assert: vocabulary unknownSymbol equals: '<unk>'
]

{ #category : #tests }
NgramModelVocabularyTest >> testVocabularySize [
	self assert: vocabulary size equals: 4.
]

{ #category : #tests }
NgramModelVocabularyTest >> testWords [
	self assert: vocabulary words equals: words.
]
