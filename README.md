#Matchismo

This is my implementation of Matchismo. You can find the parts that I added to this in [the issues](https://bitbucket.org/kentcdodds/assignment1/issues).

##TL;DR

###Design Decisions

####Display

There is a string generated for display purposes to show the user what their last action just did (whether it matched, didn't match, points awarded/penalized, etc). I decided to make the controller do this. It's possible that the view could be the right place for this, but I opted to avoid putting logic in the view to determine what the message should be.

####Comments (lie)

I tried to write my code in a way that it was readable enough to not require comments because I believe that comments begin to lie as soon as their written (because the code is the true holder of the truth, not comments which don't affect the run of the program). There are comments occasionally when the logic is difficult enough or the implementation is odd enough to require an explanation, but for the most part, hopefully the code is readable enough to not require comments.

###Answers to your questions

####What did you do really well, not so well?

I had a hard time getting everything setup. I had to start it all from scratch and used a combination of the notes and some examples online to build the foundation. Once everything was setup (step 1 completed) then I was able to move forward without much of a hitch. I setup a remote repo on Bitbucket.org and used the issue tracker to keep track of progress on requirements. Pretty handy!

####What was your experience like in this assignment?

I would say my experience was pretty good. My fingers got an exercise they have never experienced with JavaScript that's for sure. I've learned some of the nuances of Objective-C some of which are neat and others of which are frustrating or odd. Overall though, I appreciated the assignment. I also learned that in the XCode world, you're expected to learn more from the documentation than sites like StackOverflow which is not the case with other platforms I have developed on.

####Did it help you learn, or do you have ideas on how to improve the assignment?

It certainly helped me learn and I really appreciate that we're following a structured course of study that most iOS developers (it seems) started with.