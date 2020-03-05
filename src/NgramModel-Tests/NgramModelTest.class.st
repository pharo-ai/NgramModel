Class {
	#name : #NgramModelTest,
	#superclass : #TestCase,
	#category : #'NgramModel-Tests'
}

{ #category : #tests }
NgramModelTest >> testEmptyModelAssignsZeroCountToNgramOfRightOrder [
	| model ngram |
	model := NgramModel order: 2.
	ngram := #(lorem ipsum) asNgram.
	self assert: (model countOfNgram: ngram) equals: 0.
]

{ #category : #tests }
NgramModelTest >> testEmptyModelHasTotalNgramCount0 [
	| model |
	model := NgramModel order: 2.
	self assert: model totalNgramCountInText equals: 0.
]

{ #category : #tests }
NgramModelTest >> testEmptyModelHasVocabularyOfSize1 [
	| model |
	model := NgramModel order: 2.
	self assert: model vocabulary size equals: 1.
	self assert: (model vocabulary includes: String new defaultNgramPadding).
]

{ #category : #tests }
NgramModelTest >> testEmptyModelOfOrder2HasOrder2 [
	| model |
	model := NgramModel order: 2.
	self assert: model order equals: 2.
]

{ #category : #tests }
NgramModelTest >> testMinCountThreshold [
	| model text ngram1 ngram2 ngram3 ngram4 ngram5 |
	model := NgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram1 := #('<s>' lorem) asNgram.
	ngram2 := #(lorem ipsum) asNgram.
	ngram3 := #(ipsum ipsum) asNgram.
	ngram4 := #(ipsum dolor) asNgram.
	ngram5 := #(dolor '<s>') asNgram.
	
	model trainOnSentence: text.
	model removeNgramsWithCountsLessThan: 2.
	
	self assert: (model countOfNgram: ngram1) equals: 0.
	self assert: (model countOfNgram: ngram2) equals: 0.
	self assert: (model countOfNgram: ngram3) equals: 2.
	self assert: (model countOfNgram: ngram4) equals: 0.
	self assert: (model countOfNgram: ngram5) equals: 0.
]

{ #category : #tests }
NgramModelTest >> testTrainedBigramModelIsProbabilityDistribution [
	| text vocab model ngram sumOfProbabilities |
	text := 'Lorem ipsum dolor sit amet'.
	vocab := #('<s>' Lorem ipsum dolor sit amet).
	
	model := NgramModel order: 2.
	model trainOnSentence: text.
	
	vocab do: [ :firstWord |
		sumOfProbabilities := vocab inject: 0 into: [ :sum :secondWord |
			ngram := { firstWord . secondWord } asNgram.
			sum + (model probabilityOfNgram: ngram) ].
		
		self assert: sumOfProbabilities equals: 1 ].
]

{ #category : #tests }
NgramModelTest >> testTrainedModelCounts [
	| model text ngram1 ngram2 ngram3 ngram4 ngram5 |
	model := NgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram1 := #('<s>' lorem) asNgram.
	ngram2 := #(lorem ipsum) asNgram.
	ngram3 := #(ipsum ipsum) asNgram.
	ngram4 := #(ipsum dolor) asNgram.
	ngram5 := #(dolor '<s>') asNgram.
	
	model trainOnSentence: text.
	
	self assert: (model countOfNgram: ngram1) equals: 1.
	self assert: (model countOfNgram: ngram2) equals: 1.
	self assert: (model countOfNgram: ngram3) equals: 2.
	self assert: (model countOfNgram: ngram4) equals: 1.
	self assert: (model countOfNgram: ngram5) equals: 1.
]

{ #category : #tests }
NgramModelTest >> testTrainedModelProbabilitiesOfNgrams [
	| model text ngram1 ngram2 ngram3 ngram4 ngram5 |
	model := NgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram1 := #('<s>' lorem) asNgram.
	ngram2 := #(lorem ipsum) asNgram.
	ngram3 := #(ipsum ipsum) asNgram.
	ngram4 := #(ipsum dolor) asNgram.
	ngram5 := #(dolor '<s>') asNgram.
	
	model trainOnSentence: text.
	
	self assert: (model probabilityOfNgram: ngram1) equals: 1.
	self assert: (model probabilityOfNgram: ngram2) equals: 1.
	self assert: (model probabilityOfNgram: ngram3) equals: 2/3 asFloat.
	self assert: (model probabilityOfNgram: ngram4) equals: 1/3 asFloat.
	self assert: (model probabilityOfNgram: ngram5) equals: 1.
]

{ #category : #tests }
NgramModelTest >> testTrainedModelProbabilityOfUnknownNgramWithKnownHistoryIs0 [
	| model text ngram |
	model := NgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram := #(ipsum hello) asNgram.
	
	model trainOnSentence: text.
	
	self assert: (model probabilityOfNgram: ngram) equals: 0.
]

{ #category : #tests }
NgramModelTest >> testTrainedModelProbabilityOfUnknownNgramWithUnknownHistoryIs0 [
	| model text ngram |
	model := NgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram := #(world hello) asNgram.
	
	model trainOnSentence: text.
	
	self assert: (model probabilityOfNgram: ngram) equals: 0.
]

{ #category : #tests }
NgramModelTest >> testTrainedModelSelfProbabilityOfText [
	| model text |
	model := NgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	
	model trainOnSentence: text.
	self
		assert: (model probabilityOfText: text)
		closeTo: 2/3 * 2/3 * 1/3 asFloat.
]

{ #category : #tests }
NgramModelTest >> testTrainedModelSelfProbabilityOfUniformTextIs1 [
	| model text |
	model := NgramModel order: 2.
	
	text := 'lorem ipsum dolor sit amet'.
	model trainOnSentence: text.
	
	self assert: (model probabilityOfText: text) equals: 1.
]

{ #category : #tests }
NgramModelTest >> testTrainedModelVocabulary [
	| model text words |
	model := NgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	words := #('<s>' lorem ipsum dolor) asSet.
	
	model trainOnSentence: text.

	self assert: model vocabulary equals: words.
]

{ #category : #tests }
NgramModelTest >> testTrainedUnigramModelIsProbabilityDistribution [
	| text vocab model ngram sumOfProbabilities |
	text := 'Lorem ipsum dolor sit amet'.
	vocab := #('<s>' Lorem ipsum dolor sit amet).
	
	model := NgramModel order: 1.
	model trainOnSentence: text.
	
	sumOfProbabilities := vocab inject: 0 into: [ :sum :word |
		ngram := { word } asNgram.
		sum + (model probabilityOfNgram: ngram) ].
		
	self assert: sumOfProbabilities equals: 1.
]
