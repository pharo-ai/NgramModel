Class {
	#name : #EntropyTest,
	#superclass : #TestCase,
	#category : #'NgramModelMetrics-Tests'
}

{ #category : #tests }
EntropyTest >> testEntropyOfBigramModel [
	| model text expected actual |
	model := NgramModel order: 2.
	text := 'Lorem ipsum ipsum ipsum dolor'.
	model trainOn: text.
	
	expected := -1/6 * ({ 1 . 1 . 2/3 . 2/3 . 1/3 . 1 } collect: [ :x | x log: 2 ]) sum.
	actual := Entropy of: model on: { text }.
	
	self assert: actual closeTo: expected.
]
