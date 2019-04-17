Class {
	#name : #PerplexityTest,
	#superclass : #TestCase,
	#category : #'NgramModelMetrics-Tests'
}

{ #category : #tests }
PerplexityTest >> testPerplexityOfBigramModel [
	| model text entropy expected actual |
	model := NgramModel order: 2.
	text := 'Lorem ipsum ipsum ipsum dolor'.
	model trainOnSentence: text.
	
	entropy := -1/6 * ({ 1 . 1 . 2/3 . 2/3 . 1/3 . 1 } collect: [ :x | x log: 2 ]) sum.
	expected := 2 ** entropy.
	actual := Perplexity of: model on: { text }.
	
	self assert: actual closeTo: expected.
]
