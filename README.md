# Project Euler Problem 22 Solution
This a solution to [Problem #22 from Project Euler](https://projecteuler.net/problem=22) : 

### What is Project Euler?

>Project Euler is a series of challenging mathematical/computer programming problems that will require more than just mathematical insights to solve. Although mathematics will help you arrive at elegant and efficient methods, the use of a computer and programming skills will be required to solve most problems.

-https://projecteuler.net/about

### Problem 22
>Using names.txt, a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
>
>For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
>
>What is the total of all the name scores in the file?

### Features
The total_score method on the NamesScores class can be used to determine the resulting total score.
```
total_score = NamesScores.total_score(names)
```
The script in solution.rb yields the asnwer for the provided names.txt file
```
Project Euler - Problem 22 Solution: 871,198,282
```

### Names files

### Running tests
The singular spec file for NamesScores can simply be run using Rspec.

### Built using:
- **Ruby** - ruby 2.6.6p146 (2020-03-31 revision 67876)
- **Rspec** - 3.10.0