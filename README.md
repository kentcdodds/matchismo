#Matchismo (Assignment 1)

This is my implementation of Matchismo. You can find the parts that I added to this in [the issues](https://bitbucket.org/kentcdodds/assignment1/issues).

##TL;DR

###Design Decisions

####Display

There is a string generated for display purposes to show the user what their last action just did (whether it matched, didn't match, points awarded/penalized, etc). I decided to make the controller do this. It's possible that the view could be the right place for this, but I opted to avoid putting logic in the view to determine what the message should be.

####Comments (lie)

I tried to write my code in a way that it was readable enough to not require comments because I believe that comments begin to lie as soon as their written (because the code is the true holder of the truth, not comments which don't affect the run of the program). There are comments occasionally when the logic is difficult enough or the implementation is odd enough to require an explanation, but for the most part, hopefully the code is readable enough to not require comments.