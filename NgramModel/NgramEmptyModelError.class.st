Class {
	#name : #NgramEmptyModelError,
	#superclass : #Error,
	#type : #variable,
	#category : #NgramModel
}

{ #category : #accessing }
NgramEmptyModelError >> messageText [ 
	^ 'This model was not trained yet'
]
