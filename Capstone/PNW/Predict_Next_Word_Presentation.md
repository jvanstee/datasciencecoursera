<style>

/* slide titles */
.section .reveal .state-background {
background: white;
}
.section .reveal p {
font-family: Verdana, Arial, Helvetica, sans-serif;
color: black;
text-align:left; 
width:100%;
line-height: 0.15em;
#margin-top: 70px;
}
.section .reveal h1, .section {
font-family: Verdana, Arial, Helvetica, sans-serif;
color: #2B89F9;
font-size: 80px;
margin-top: 30px;
}
.reveal pre code {
	font-family: Verdana, Arial, Helvetica, sans-serif;
  background-color: #E8F6FC;
  color:black;
  font-size: 35px;
  position: fixed; top: 60%;
  text-align:center; width:85%;
  }

.reveal h3 { 
  font-size: 60px;
  color: #2B89F9  ;
}

#/* heading for slides with two hashes ## */
#.reveal .slides section .slideContent h2 {
#   font-size: 20px;
#   font-weight: bold;
#   color: green;
#}

/* ordered and unordered list styles */
.reveal ul, 
.reveal ol {
    font-size: 20px;
    color:black
    list-style-type: square;
  
#.reveal h1, .reveal h2, .reveal h3 {
#      word-wrap: normal;
#     -moz-hyphens: none;
#  }


</style>
Next Word Prediction
======================================================== 
font-family: 'Helvetica'
transition: rotate

        Coursera/Johns Hopkins University 
          In partnership with Swiftkey
           Data Science Specialization
                Capstone Project 

JP Van Steerteghem 

March 12, 2018

Introduction 
========================================================

- We built a prototype for a predictive text product

- It was developed on MacBook Air running MacOS High Sierra, with a 2.2 GHz Intel Core i7 processor with 8 GB 1600 MHz DDR3 Memory

- It is simple but works fast and right!

  - Average response time under 1 second

  - Application memory usage under 10 MB

- One can try the prototype at: https://jvanstee.shinyapps.io/predict_next_word2/

- Documentation of the Capstone project can be foud at: https://github.com/jvanstee/Capstone/tree/master/Capstone

How does it work? - Building the language model.
========================================================

- A large corpus of blog (200MB), news (196MB) and twitter (159MB) data are used to train the product
- Dataset was cleaned and punctuations, numbers, separators, English stopwords and profanity were removed.
- ngrams are used to build this predictive language model.  
  - 1-grams, 2-grams, 3-grams and 4-grams were extracted from 15% of the corpus using "quanteda".
  - ngrams are stored in a table and sorted by frequency
- A key element of the development effort was to optimize memory efficiency while maintaining model accuracy:
  - The size of the model was reduced by dropping N-grams with a frequency lower than 5
  - Objects were removed when not needed anymore to free up memory

How does it work? - Next word prediction
========================================================

- A word or phrase is entered in a text input box

- Once Predict button is clicked the prediction algorithm looks for up to 3 "next word" options

- A next word back-off algorithm is used

  - Iterates from longest N-gram (4-gram) to shortest (2-gram)

  - Predicts using the longest, most frequent, matching N-gram
  
  - if no match is found a "?" is returned


Resources and next steps
========================================================

Next Steps:
- refine the model using  alternate smoothing algorithms:
  - Katz Back Off
  - Kneser-Ney 
- increase the size of the training data, without jeopardizing usability
- get a more powerful compute platform

The following are excellent resources to help with next steps:
- Understanding Katz Back-Off Model by Michael Szczepaniak- http://rpubs.com/mszczepaniak/predictkbo3model
- Language modeling with Ngrams by Daniel Jurafsky and James H Martin - https://web.stanford.edu/~jurafsky/slp3/4.pdf
