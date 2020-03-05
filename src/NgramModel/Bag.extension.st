Extension { #name : #Bag }

{ #category : #'*NgramModel' }
Bag >> rejectWithOccurrences: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements and counts as the arguments. Collect into a new collection like the receiver only those elements for which aBlock evaluates to false. Answer the new collection."
	"(#(1 2 1 1 2 1 2 3 3 3) asBag rejectWithOccurrences: [ :each :count | each odd and: (count < 4) ]) >>> #(1 1 1 1 2 2 2) asBag"

	^ self selectWithOccurrences: [ :element :count | (aBlock value: element value: count) == false ]
]

{ #category : #'*NgramModel' }
Bag >> selectWithOccurrences: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements and occurences as the argument. Collect into a new collection like the receiver, only those elements for which aBlock evaluates to true. Answer the new collection."
	"(#(1 2 1 1 2 1 2 3 3 3) asBag selectWithOccurrences: [ :each :count | each odd and: (count < 4) ]) >>> #(3 3 3) asBag"
	
	| newCollection |
	newCollection := self copyEmpty.
	self doWithOccurrences: [ :each :count | 
		(aBlock value: each value: count) 
			ifTrue: [ newCollection add: each withOccurrences: count ]].
	^newCollection
]
