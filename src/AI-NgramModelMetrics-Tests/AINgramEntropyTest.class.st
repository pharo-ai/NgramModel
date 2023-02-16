Class {
	#name : #AINgramEntropyTest,
	#superclass : #TestCase,
	#category : #'AI-NgramModelMetrics-Tests'
}

{ #category : #tests }
AINgramEntropyTest >> testEntropyOfBigramModel [
	| model text expected actual |
	model := AINgramModel order: 2.
	text := 'Lorem ipsum ipsum ipsum dolor'.
	model trainOnSentence: text.
	
	expected := -1/6 * ({ 1 . 1 . 2/3 . 2/3 . 1/3 . 1 } collect: [ :x | x log: 2 ]) sum.
	actual := AINgramEntropy of: model on: { text }.
	
	self assert: actual closeTo: expected.
]
