Class {
	#name : #NgramModelWithLaplaceSmoothingTest,
	#superclass : #TestCase,
	#instVars : [
		'smoothing'
	],
	#category : #'NgramModel-Tests'
}

{ #category : #tests }
NgramModelWithLaplaceSmoothingTest >> setUp [ 
	smoothing := NgramLaplaceSmoothing new.
]

{ #category : #tests }
NgramModelWithLaplaceSmoothingTest >> testCanBeInitialized [
	| model |
	model := NgramModel order: 2 withSmoothing: smoothing.
	self assert: smoothing model equals: model
]

{ #category : #tests }
NgramModelWithLaplaceSmoothingTest >> testTrainedBigramModelIsProbabilityDistribution [
	| text vocab model ngram sumOfProbabilities |
	text := 'Lorem ipsum dolor sit amet'.
	vocab := #('<s>' Lorem ipsum dolor sit amet).
	
	model := NgramModel order: 2 withSmoothing: smoothing.
	model trainOn: text.
	
	vocab do: [ :firstWord |
		sumOfProbabilities := vocab inject: 0 into: [ :sum :secondWord |
			ngram := { firstWord . secondWord } asNgram.
			sum + (model probabilityOfNgram: ngram) ].
		
		self assert: sumOfProbabilities closeTo: 1 ].
]

{ #category : #tests }
NgramModelWithLaplaceSmoothingTest >> testTrainedModelCounts [
	| model text ngram1 ngram2 ngram3 ngram4 ngram5 |
	model := NgramModel order: 2 withSmoothing: smoothing.
	
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
NgramModelWithLaplaceSmoothingTest >> testTrainedModelProbabilitiesOfNgrams [
	| model text vocab ngram1 ngram2 ngram3 ngram4 ngram5 |
	model := NgramModel order: 2 withSmoothing: smoothing.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	vocab := #('<s>' lorem ipsum dolor).
	
	ngram1 := #('<s>' lorem) asNgram.
	ngram2 := #(lorem ipsum) asNgram.
	ngram3 := #(ipsum ipsum) asNgram.
	ngram4 := #(ipsum dolor) asNgram.
	ngram5 := #(dolor '<s>') asNgram.
	
	model trainOn: text.
	
	self assert: (model probabilityOfNgram: ngram1) equals: (1 + 1) / (1 + vocab size) asFloat.
	self assert: (model probabilityOfNgram: ngram2) equals: (1 + 1) / (1 + vocab size) asFloat.
	self assert: (model probabilityOfNgram: ngram3) equals: (2 + 1) / (3 + vocab size) asFloat.
	self assert: (model probabilityOfNgram: ngram4) equals: (1 + 1) / (3 + vocab size) asFloat.
	self assert: (model probabilityOfNgram: ngram5) equals: (1 + 1) / (1 + vocab size) asFloat.
]

{ #category : #tests }
NgramModelWithLaplaceSmoothingTest >> testTrainedModelSelfProbabilityOfText [
	| model text |
	model := NgramModel order: 2 withSmoothing: smoothing.
	
	text := 'lorem ipsum ipsum ipsum dolor'.
	
	model trainOn: text.
	self
		assert: (model probabilityOfText: text)
		closeTo: (2/5) ** 3 * ((3/7) ** 2) * 2/7 asFloat.
]

{ #category : #tests }
NgramModelWithLaplaceSmoothingTest >> testTrainedUnigramModelIsProbabilityDistribution [
	| text vocab model ngram sumOfProbabilities |
	text := 'Lorem ipsum dolor sit amet'.
	vocab := #('<s>' Lorem ipsum dolor sit amet).
	
	model := NgramModel order: 1 withSmoothing: smoothing.
	model trainOn: text.
	
	sumOfProbabilities := vocab inject: 0 into: [ :sum :word |
		ngram := { word } asNgram.
		sum + (model probabilityOfNgram: ngram) ].
		
	self assert: sumOfProbabilities equals: 1.
]
