Class {
	#name : #BaselineOfNgramModel,
	#superclass : #BaselineOf,
	#category : #BaselineOfNgramModel
}

{ #category : #baselines }
BaselineOfNgramModel >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'Ngram';
			package: 'NgramModel' with: [ spec requires: #( 'Ngram' ) ];
			package: 'NgramModelTextGenerator' with: [ spec requires: #( 'NgramModel' ) ];
			package: 'Ngram-Tests' with: [ spec requires: #( 'Ngram' ) ];
			package: 'NgramModel-Tests' with: [ spec requires: #( 'NgramModel' ) ].

		spec group: 'Ngram' with: #( 'Ngram' 'Ngram-Tests' ) ]
]
