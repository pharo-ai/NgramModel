Class {
	#name : #BaselineOfNgramModel,
	#superclass : #BaselineOf,
	#category : #BaselineOfNgramModel
}

{ #category : #baselines }
BaselineOfNgramModel >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'Ngram'
			with: [ spec repository: 'github://olekscode/Ngram/src' ].
				
		"Packages"
		spec 
			package: 'NgramModel' with: [ spec requires: #('Ngram') ];
			package: 'NgramModel-Tests' with: [ spec requires: #('NgramModel') ];
			package: 'NgramModelTextGenerator' with: [ spec requires: #('NgramModel') ] ].
]
