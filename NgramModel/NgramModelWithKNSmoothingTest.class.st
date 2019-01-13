Class {
	#name : #NgramModelWithKNSmoothingTest,
	#superclass : #TestCase,
	#instVars : [
		'smoothing',
		'discount'
	],
	#category : #NgramModel
}

{ #category : #running }
NgramModelWithKNSmoothingTest >> setUp [ 
	discount := 0.75.
	smoothing := NgramKNSmoothing withAbsoluteDiscount: discount.
]

{ #category : #tests }
NgramModelWithKNSmoothingTest >> testCanBeInitialized [
	| model |
	model := NgramModel order: 2 withSmoothing: smoothing.
	self assert: smoothing model equals: model
]

{ #category : #tests }
NgramModelWithKNSmoothingTest >> testTrainedBigramModelIsProbabilityDistribution [
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
NgramModelWithKNSmoothingTest >> testTrainedModelCounts [
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
NgramModelWithKNSmoothingTest >> testTrainedUnigramModelIsProbabilityDistribution [
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
