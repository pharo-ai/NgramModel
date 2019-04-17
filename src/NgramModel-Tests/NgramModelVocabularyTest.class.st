Class {
	#name : #NgramModelVocabularyTest,
	#superclass : #TestCase,
	#instVars : [
		'vocabulary',
		'words'
	],
	#category : #'NgramModel-Tests'
}

{ #category : #running }
NgramModelVocabularyTest >> setUp [ 
	vocabulary := NgramModelVocabulary new.
	vocabulary
		add: 'lorem';
		add: 'ipsum';
		add: 'lorem'.
		
	words := Set
		with: 'lorem'
		with: 'ipsum'.
]

{ #category : #tests }
NgramModelVocabularyTest >> testNewVocabularyIsEmpty [
	self assert: NgramModelVocabulary new isEmpty.
]

{ #category : #tests }
NgramModelVocabularyTest >> testNewVocabularySizeIs0 [
	self assert: NgramModelVocabulary new size equals: 0.
]

{ #category : #tests }
NgramModelVocabularyTest >> testNumberOfReservedTokens [
	self assert: vocabulary numberOfReservedTokens equals: 1
]

{ #category : #tests }
NgramModelVocabularyTest >> testVocabularySize [
	self assert: vocabulary size equals: 2.
]

{ #category : #tests }
NgramModelVocabularyTest >> testWords [
	self assert: vocabulary words equals: words.
]
