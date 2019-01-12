# Ngram language model implemented in Pharo
## Example of text generation

#### 1. Loading Brown corpus
```Smalltalk
file := '/Users/oleks/Documents/TextCorpora/brown_corpus.txt' asFileReference.
brown := file contents.
```
#### 2. Training a 2-gram language model on the corpus
```Smalltalk
model := NgramModel order: 2.
model trainOn: brown.
```
#### 3. Generating text of 100 words
At each step the model selects top 5 words that are most likely to follow the previous words and returns the random word from those five (this randomnes ensures that the generator does not get stuck in a cycle).
```Smalltalk
generator := NgramTextGenerator new model: model.
generator generateTextOfSize: 100.
```
#### Result:
```
 educator cannot describe and edited a highway at private time ``
 Fallen Figure Technique tells him life pattern more flesh tremble 
 with neither my God `` Hit ) landowners began this narrative and 
 planted , post-war years Josephus Daniels was Virginia years 
 Congress with confluent , jurisdiction involved some used which 
 he''s something the Lyle Elliott Carter officiated and edited and
 portents like Paradise Road in boatloads . Shipments of Student 
 Movement itself officially shifted religions of fluttering soutane .
 Coolest shade which reasonably . Coolest shade less shaky . Doubts 
 thus preventing them proper bevels easily take comfort was
```
