Class {
	#name : #AINgramPerplexityTest,
	#superclass : #TestCase,
	#category : #'AI-NgramModelMetrics-Tests'
}

{ #category : #tests }
AINgramPerplexityTest >> testPerplexityOfBigramModel [
	| model text entropy expected actual |
	model := AINgramModel order: 2.
	text := 'Lorem ipsum ipsum ipsum dolor'.
	model trainOnSentence: text.
	
	entropy := -1/6 * ({ 1 . 1 . 2/3 . 2/3 . 1/3 . 1 } collect: [ :x | x log: 2 ]) sum.
	expected := 2 ** entropy.
	actual := AINgramPerplexity of: model on: { text }.
	
	self assert: actual closeTo: expected.
]
