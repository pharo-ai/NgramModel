Class {
	#name : #AINgramModelTest,
	#superclass : #TestCase,
	#category : #'AI-NgramModel-Tests'
}

{ #category : #tests }
AINgramModelTest >> testEmptyModelAssignsZeroCountToNgramOfRightOrder [
	| model ngram |
	model := AINgramModel order: 2.
	ngram := #(lorem ipsum) asNgram.
	self assert: (model countOfNgram: ngram) equals: 0.
]

{ #category : #tests }
AINgramModelTest >> testEmptyModelHasTotalNgramCount0 [
	| model |
	model := AINgramModel order: 2.
	self assert: model totalNgramCountInText equals: 0.
]

{ #category : #tests }
AINgramModelTest >> testEmptyModelHasVocabularyOfSize1 [
	| model |
	model := AINgramModel order: 2.
	self assert: model vocabulary size equals: 1.
	self assert: (model vocabulary includes: String new defaultNgramPadding).
]

{ #category : #tests }
AINgramModelTest >> testEmptyModelOfOrder2HasOrder2 [
	| model |
	model := AINgramModel order: 2.
	self assert: model order equals: 2.
]

{ #category : #tests }
AINgramModelTest >> testEntireTrainedModelCounts [
	| model tokens |
	model := AINgramModel order: 2.
	tokens := #(
			(lorem ipsum dolor sit amet)
			(lorem ipsum sit)
			(lorem dolor amet)).
	model trainOn: tokens.
	
	self assert: (model countOfNgram: #(lorem ipsum) asNgram) equals: 2.
	self assert: (model countOfNgram: #(dolor sit) asNgram) equals: 1.
]

{ #category : #tests }
AINgramModelTest >> testEntireTrainedModelCountsIfNgramsNotKnown [
	| model tokens |
	model := AINgramModel order: 2.
	tokens := #(
			(lorem ipsum dolor sit amet)
			(lorem ipsum sit)
			(lorem dolor amet)).
	model trainOn: tokens.

	self assert: (model countOfNgram: #(ipsum lorem) asNgram) equals: 0.
	self assert: (model countOfNgram: #(hello world) asNgram) equals: 0.
]

{ #category : #tests }
AINgramModelTest >> testEntireTrainedModelProbabilities [
	| model tokens |
	model := AINgramModel order: 2.
	tokens := #(
			(lorem ipsum dolor sit amet)
			(lorem ipsum sit)
			(lorem dolor amet)).
	model trainOn: tokens.
	
	self assert: (model probabilityOfNgram: #(lorem ipsum) asNgram) equals: (2/3 asFloat).
	self assert: (model probabilityOfNgram: #(lorem dolor) asNgram) equals: (1/3 asFloat).
	self assert: (model probabilityOfNgram: #(dolor sit) asNgram) equals: (1/2 asFloat).
]

{ #category : #tests }
AINgramModelTest >> testEntireTrainedModelProbabilitiesIfNgramsNotKnown [
	| model tokens |
	model := AINgramModel order: 2.
	tokens := #(
			(lorem ipsum dolor sit amet)
			(lorem ipsum sit)
			(lorem dolor amet)).
	model trainOn: tokens.

	self assert: (model probabilityOfNgram: #(lorem amet) asNgram) equals: 0.
	self assert: (model probabilityOfNgram: #(hello world) asNgram) equals: 0.
]

{ #category : #tests }
AINgramModelTest >> testMinCountThreshold [
	| model text ngram1 ngram2 ngram3 ngram4 ngram5 |
	model := AINgramModel order: 2.
	
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
AINgramModelTest >> testTrainedBigramModelIsProbabilityDistribution [
	| text vocab model ngram sumOfProbabilities |
	text := 'Lorem ipsum dolor sit amet'.
	vocab := #('<s>' Lorem ipsum dolor sit amet).
	
	model := AINgramModel order: 2.
	model trainOnSentence: text.
	
	vocab do: [ :firstWord |
		sumOfProbabilities := vocab inject: 0 into: [ :sum :secondWord |
			ngram := { firstWord . secondWord } asNgram.
			sum + (model probabilityOfNgram: ngram) ].
		
		self assert: sumOfProbabilities equals: 1 ].
]

{ #category : #tests }
AINgramModelTest >> testTrainedModelCounts [
	| model text ngram1 ngram2 ngram3 ngram4 ngram5 |
	model := AINgramModel order: 2.
	
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
AINgramModelTest >> testTrainedModelLogProbabilityOfText [
	| model text |
	model := AINgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	"<s> lorem 1
	lorem ipsum 1
	ipsum ipsum 2/3
	ipsum ipsum 2/3
	ipsum dolor 1/3
	dolor <s> 1"
	
	model trainOnSentence: text.
	self
		assert: (model logProbabilityOfText: text)
		closeTo: (1 log + 1 log + (2/3) log + (2/3) log + (1/3) log + 1 log) asFloat.
]

{ #category : #tests }
AINgramModelTest >> testTrainedModelProbabilitiesOfNgrams [
	| model text ngram1 ngram2 ngram3 ngram4 ngram5 |
	model := AINgramModel order: 2.
	
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
AINgramModelTest >> testTrainedModelProbabilityOfUnknownNgramWithKnownHistoryIs0 [
	| model text ngram |
	model := AINgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram := #(ipsum hello) asNgram.
	
	model trainOnSentence: text.
	
	self assert: (model probabilityOfNgram: ngram) equals: 0.
]

{ #category : #tests }
AINgramModelTest >> testTrainedModelProbabilityOfUnknownNgramWithUnknownHistoryIs0 [
	| model text ngram |
	model := AINgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	ngram := #(world hello) asNgram.
	
	model trainOnSentence: text.
	
	self assert: (model probabilityOfNgram: ngram) equals: 0.
]

{ #category : #tests }
AINgramModelTest >> testTrainedModelSelfProbabilityOfText [
	| model text |
	model := AINgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	"<s> lorem 1
	lorem ipsum 1
	ipsum ipsum 2/3
	ipsum ipsum 2/3
	ipsum dolor 1/3
	dolor <s> 1"

	model trainOnSentence: text.
	self
		assert: (model probabilityOfText: text)
		closeTo: (1 * 1 * 2/3 * 2/3 * 1/3 * 1) asFloat.
]

{ #category : #tests }
AINgramModelTest >> testTrainedModelSelfProbabilityOfUniformTextIs1 [
	| model text |
	model := AINgramModel order: 2.
	
	text := 'lorem ipsum dolor sit amet'.
	model trainOnSentence: text.
	
	self assert: (model probabilityOfText: text) equals: 1.
]

{ #category : #tests }
AINgramModelTest >> testTrainedModelVocabulary [
	| model text words |
	model := AINgramModel order: 2.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	words := #('<s>' lorem ipsum dolor) asSet.
	
	model trainOnSentence: text.

	self assert: model vocabulary equals: words.
]

{ #category : #tests }
AINgramModelTest >> testTrainedUnigramModelIsProbabilityDistribution [
	| text vocab model ngram sumOfProbabilities |
	text := 'Lorem ipsum dolor sit amet'.
	vocab := #('<s>' Lorem ipsum dolor sit amet).
	
	model := AINgramModel order: 1.
	model trainOnSentence: text.
	
	sumOfProbabilities := vocab inject: 0 into: [ :sum :word |
		ngram := { word } asNgram.
		sum + (model probabilityOfNgram: ngram) ].
		
	self assert: sumOfProbabilities equals: 1.
]
