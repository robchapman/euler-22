# Project Euler Problem 22 Solution
This a solution to [Problem #22 from Project Euler](https://projecteuler.net/problem=22) : 

## What is Project Euler?

>Project Euler is a series of challenging mathematical/computer programming problems that will require more than just mathematical insights to solve. Although mathematics will help you arrive at elegant and efficient methods, the use of a computer and programming skills will be required to solve most problems.

-https://projecteuler.net/about

## Problem 22
>Using names.txt, a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
>
>For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
>
>What is the total of all the name scores in the file?

## Features
### Initialization
A new class instance can be created by passing optionally passing the below key paramters:
```
names_scores = NamesScores.new(names: some_names, sort: some_sorter, score: some_scorer, total: some_totaller)
```
- **names:** An array of name strings or a File with comma seperated names
- **sort:** A lambda object that implements a comparison between two variables (a,b) and returns an integer less than 0 when b follows a, 0 when and b are equivalent, or an integer greater than 0 when a follows b. This is as per the block required for the standard ruby Enumerable#sort method.
- **score:** A lambda object that produces an Integer score for a given name provided as a string variable.
- **total:** A lambda object that produces a final score for the set of names given the names as an Array variable and the scoring function as defined above.

For example the default parameters for a NamesScores object reflect the sorting/scoring and totalling behaviour required to solve the Euler Project Question:
An ascending alphabetic sort
```
  DEFAULT_SORT = ->(a, b) { a <=> b }
```

A score calculated based on sum of letters alphabetic order (A = 1, B = 2, etc.)
```
  DEFAULT_SCORE = ->(name) { name.scan(/[a-zA-Z]/).sum { |chr| chr.upcase.ord - 64 } }
```

The total score is equivalent to sum of individual names multuplied by their
position in the sorted array of names
```
  DEFAULT_TOTAL = lambda { |names, score|
    total = 0
    names.each_with_index { |name, index| total += score.call(name) * (index + 1) }
    total
  }

```

### Default Scoring and Totalling
- The scoring method is case insensitive and will ignore non-letter characters
- An empty array or file will return a score of zero
- Empty name strings will be scored as zero but will occupy an array position for calculation of total score of the list of names.

### The names parameter
The method will accept either an Array of strings or comma seperated names within a txt file.
**Array Parameter Usage**
```
names_array = ["MARY","PATRICIA","LINDA"]
names_scores = NamesScores.new(names: names_array)
puts names_scores.total_score

>> 385
```
**File Parameter Usage**
```
#names.txt
"MARY","PATRICIA","LINDA"

#solve.rb
names_file = File.open('names.txt')
names_scores = NamesScores.new(names: names_file)
puts names_scores.total_score

>> 385
```
*Be aware that a File opened to be provided to the total_score method will be closed automatically*


### #total_score
The total_score method on the on an instance of a NamesScores object can be used to determine the resulting total score of the name strings provided.
```
names_scores = NamesScores.new(names:['MARY', 'PATRICIA', 'LINDA']
puts names_scores.sorted_names

>> 385
```

### #sorted_names
#sorted_names will return the names the object was instantiated with as an Array of String obkects according to the `sort` variable it was instantiated with.
```
names_scores = NamesScores.new(names: ["ZEE", "AARON"]
puts names_scores.sorted_names

>> ["AARON", "ZEE"]
```

### #score
#score will return the score for a given name String in Integer form. 
```
puts names_scores.score("COLIN")

>> 53
```

## Problem Solution
The script in solution.rb will print the answer for the provided names.txt file provided by the project euler problem:
```
Project Euler - Problem 22 Solution: 871,198,282
```

## Running tests
The singular spec file for NamesScores can simply be run with RSpec.
RSpec version is provided in the provided Gemfile.

## Built using:
- **Ruby** - ruby 2.6.6p146 (2020-03-31 revision 67876)
- **RSpec** - 3.10.0
