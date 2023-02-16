Class {
	#name : #BaselineOfNgramModel,
	#superclass : #BaselineOf,
	#category : #BaselineOfNgramModel
}

{ #category : #testing }
BaselineOfNgramModel class >> isDeprecated [
	^ true
]

{ #category : #baselines }
BaselineOfNgramModel >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'AI-Ngram';
			package: 'AI-NgramModel' with: [ spec requires: #( 'AI-Ngram' ) ];
			package: 'AI-NgramModelTextGenerator' with: [ spec requires: #( 'AI-NgramModel' ) ];
			package: 'AI-Ngram-Tests' with: [ spec requires: #( 'AI-Ngram' ) ];
			package: 'AI-NgramModel-Tests' with: [ spec requires: #( 'AI-NgramModel' ) ].

		spec group: 'Ngram-core' with: #( 'AI-Ngram' 'AI-Ngram-Tests' ) ]
]
