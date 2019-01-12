Class {
	#name : #NgramModelTest,
	#superclass : #TestCase,
	#category : #NgramModel
}

{ #category : #tests }
NgramModelTest >> testCrossEntropy [
	| model text entropy |
	model := NgramModel order: 2.
	text := 'Lorem ipsum ipsum ipsum dolor'.
	model trainOn: text.
	
	entropy := -1/6 * ({ 1/6 . 1/6 . 2/6 . 2/6 . 1/6 . 1/6 } collect: [ :x | x log: 2 ]) sum.
	
	self assert: (model crossEntropyOn: text) equals: entropy.
]

{ #category : #tests }
NgramModelTest >> testEmptyModelAssignsZeroCountToNgramOfRightOrder [
	| model ngram |
	model := NgramModel order: 2.
	ngram := #(lorem ipsum) asNgram.
	self assert: (model countOfNgram: ngram) equals: 0.
]

{ #category : #tests }
NgramModelTest >> testEmptyModelHasNonEmptyVocabulary [
	| model |
	model := NgramModel order: 2.
	self assert: model vocabulary isEmpty not.
]

{ #category : #tests }
NgramModelTest >> testEmptyModelHasTotalNgramCount0 [
	| model |
	model := NgramModel order: 2.
	self assert: model totalNgramCount equals: 0.
]

{ #category : #tests }
NgramModelTest >> testEmptyModelHasVocabularyOfSize2 [
	| model |
	model := NgramModel order: 2.
	self assert: model vocabulary size equals: 2.
]

{ #category : #tests }
NgramModelTest >> testEmptyModelOfOrder2HasOrder2 [
	| model |
	model := NgramModel order: 2.
	self assert: model order equals: 2.
]

{ #category : #tests }
NgramModelTest >> testEmptyModelProbabilityOfNgramError [
	| model |
	model := NgramModel order: 1.
	
	self
		should: [ model probabilityOfNgram: #(lorem) asNgram ]
		raise: NgramEmptyModelError
]

{ #category : #tests }
NgramModelTest >> testEmptyModelProbabilityOfTextError [
	| model |
	model := NgramModel order: 1.
	
	self
		should: [ model probabilityOfText: 'Lorem ipsum' ]
		raise: NgramEmptyModelError
]

{ #category : #tests }
NgramModelTest >> testEmptyModelWasNotTrained [
	| model |
	model := NgramModel order: 1.
	self assert: model wasTrained not.
]

{ #category : #tests }
NgramModelTest >> testLogarithmBase [
	| model |
	model := NgramModel order: 3.
	self assert: model logarithmBase equals: 2.
]

{ #category : #tests }
NgramModelTest >> testPerplexity [
	| model text entropy perplexity |
	model := NgramModel order: 2.
	text := 'Lorem ipsum ipsum ipsum dolor'.
	model trainOn: text.
	
	entropy := -1/6 * ({ 1/6 . 1/6 . 2/6 . 2/6 . 1/6 . 1/6 } collect: [ :x | x log: 2 ]) sum.
	perplexity := 2 ** entropy.
	
	self assert: (model perplexityOn: text) equals: perplexity.
]

{ #category : #tests }
NgramModelTest >> testSignalsExceptionWhenCountNgramOfWrongOrder [
	| model ngram |
	model := NgramModel order: 2.
	model trainOn: 'Lorem ipsum dolor sit amet'.
	ngram := #(lorem ipsum dolor) asNgram.
	
	self
		should: [ model countOfNgram: ngram ]
		raise: NgramOrderError
]

{ #category : #tests }
NgramModelTest >> testSignalsExceptionWhenProbabilityNgramOfWrongOrder [
	| model ngram |
	model := NgramModel order: 2.
	model trainOn: 'Lorem ipsum dolor sit amet'.
	ngram := #(lorem ipsum dolor) asNgram.
	
	self
		should: [ model probabilityOfNgram: ngram ]
		raise: NgramOrderError
]

{ #category : #tests }
NgramModelTest >> testTrainedBigramModelIsProbabilityDistribution [
	| model ngrams probabilities |
	model := NgramModel order: 2.
	model trainOn: 'Lorem ipsum dolor sit amet'.
	
	ngrams := model vocabulary allNgramsOfOrder: 2.
	probabilities := ngrams asArray collect: [ :ngram | model probabilityOfNgram: ngram ].
	
	self assert: probabilities sum closeTo: 1.
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
	
	model trainOn: text.
	
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
	
	model trainOn: text.
	
	self assert: (model probabilityOfNgram: ngram1) equals: (1 / 6 asFloat).
	self assert: (model probabilityOfNgram: ngram2) equals: (1 / 6 asFloat).
	self assert: (model probabilityOfNgram: ngram3) equals: (2 / 6 asFloat).
	self assert: (model probabilityOfNgram: ngram4) equals: (1 / 6 asFloat).
	self assert: (model probabilityOfNgram: ngram5) equals: (1 / 6 asFloat).
]

{ #category : #tests }
NgramModelTest >> testTrainedModelProbabilityOfText [
	| model text |
	model := NgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	
	model trainOn: text.
	self
		assert: (model probabilityOfText: text)
		closeTo: (1/6) ** 4 * ((2/6) ** 2) asFloat.
]

{ #category : #tests }
NgramModelTest >> testTrainedModelVocabulary [
	| model text words |
	model := NgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	words := #('<s>' '<unk>' lorem ipsum dolor) asSet.
	
	model trainOn: text.

	self assert: model vocabulary words equals: words.
]

{ #category : #tests }
NgramModelTest >> testTrainedModelWasTrained [
	| model |
	model := NgramModel order: 1.
	model trainOn: 'Lorem ipsum dolor sit amet'.
	self assert: model wasTrained.
]

{ #category : #tests }
NgramModelTest >> testTrainedUnigramModelIsProbabilityDistribution [
	| model ngrams probabilities |
	model := NgramModel order: 1.
	model trainOn: 'Lorem ipsum dolor sit amet'.
	
	ngrams := model vocabulary allNgramsOfOrder: 1.
	probabilities := ngrams asArray collect: [ :ngram | model probabilityOfNgram: ngram ].
	
	self assert: probabilities sum closeTo: 1.
]
