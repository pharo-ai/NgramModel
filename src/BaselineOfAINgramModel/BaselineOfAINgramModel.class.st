Class {
	#name : #BaselineOfAINgramModel,
	#superclass : #BaselineOf,
	#category : #BaselineOfAINgramModel
}

{ #category : #baselines }
BaselineOfAINgramModel >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'AI-Ngram';
			package: 'AI-NgramModel' with: [ spec requires: #( 'AI-Ngram' ) ];
			package: 'AI-NgramModelTextGenerator' with: [ spec requires: #( 'AI-NgramModel' ) ];
			package: 'AI-Ngram-Tests' with: [ spec requires: #( 'AI-Ngram' ) ];
			package: 'AI-NgramModel-Tests' with: [ spec requires: #( 'AI-NgramModel' ) ].

		spec group: 'Ngram-core' with: #( 'Ngram' 'Ngram-Tests' ) ]
]
