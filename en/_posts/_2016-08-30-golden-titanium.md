---
title: Golden titanium alchemy
layout: post
image:
  feature: Codility.jpg
tags:
  - Programming
---

# Losing my virginity

Yeah, you are in the right blog, don't worry. I just happen to have a rather quirky sense
of humour. I'm gonna tell you the story of how I lost my virginity and won a golden award.
Oh yeah!

Recently I was sailing the internet stopping at islands of unspeakable names, when I run
aground on the most peculiar island I had ever seen on my numerous sea adventures: [Codility][1].
A seemingly paradisiacal oasis for programmers that challenged my senses and my understanding
of fun and logic.

While romping at this site like a burglar in an abandoned gold mine, I saw it: THE CHALLENGE. Well,
the uppercase letters where not there, buts its Unicode lowercase counterparts were. A new challenge
had started just few hours before, and it went by the name of Titanium[^1]

There were other tests, yes, but they belonged to the past, their petty trials paled in comparison
with this new behemoth that questioned the very nature of the human mind[^2].

And I was the chosen one, erected to tackle the Titanium Challenge!

# Baby steps

So what was all this fuzz about? 

[THIS][2].

Basically the aforementioned challenge consisted on writing a
program to solve a problem. THe language of choice could be one of many options available,
including C and C++, which I'm proficient in.

The problem? Parent matching.

> Parent matching?

Well, sorry, parenthesis matching. I was just trying to shorten the story[^3]. The problem consisted
on matching a sequence of parenthesis given as an input, along a maximum number of swaps that could be
performed on the input string. The swaps could be used to maximize the matchings. The implemented
function should return correctly the maximum number of mathched parenthesis that the procedure could
achieve by using the given number of swaps. It is important to note that the function should return
the maximum number of matched parenthesis, and not matched pairs (which in the end turns to be the
number of pairs multiplied by 2).

> How can you tackle such an overly complicated task?

Good question! Rather easilly. At least the first part, the parenthesis mathing. It turns out that apart
from a correct output, the function must also comply with space and time complexity constraints (big-O
notation). Both were bound by O(N), meaning it should run on linear time[^4] and use an amount of
memory linearly proportional to the number of input parenthesis.

So let's tackle the first part first.

# Parenthesis matching or how much did I miss my stack

How do you match parenthesis that must be nested? The answer is a stack. I hope you are familiar with
what a stack is, otherwise the rest of this article may melt your brain a bit. With a simple loop
and a stack from the C++ STL we can determine whether the input parenthesis are matched or not:

    bool isMatched(string &S)
    {
        std::stack<char> st;

        for (int i=0; i<S.length(); ++i) {
            if (S[i] == '(') {
                st.push(S[i]);
            } else if (st.top() == '(') {
                st.pop();
            } else {
                return false;
            }
        }

        return true;
    }

> That is great!

Well, yes, but not too useful. From the zillion combinations we may receive as an input only
a few will be well formed nested parenthesis expressions, but this function may be useful for
somthing else. What if we mark which parenthesis have matches? For that we will need to remember
the position of the opening parenthesis, so we can mark that position also as matched, so we will
use 2 stacks, one for matching the parenthesis, and the other one to save the positions:

    void markedMatched(string &S)
    {
        std::stack<char> st;
        std::stack<intr> pos;

        for (int i=0; i<S.length(); ++i) {
            if (S[i] == '(') {
                st.push(S[i]);
                pos.push(i);
            } else if (st.top() == '(') {
                S[i] = 'X'; 
                S[pos.top()] = 'X';

                st.pop();
                pos.pop();
            }
        }
    }

At the end of the function the string S will contain 'X' symbols in all positions with matched
parenthesis. So far so good! With this we can now actually count the number of 'X' in S and
we have a lower bound for the maximum number of matching parenthesis we can achieve[^5].

# Throw it all out the window!

This is great, but we are still not fixing the string to maximize the number of matches. How
to do that? Well this paragraph will propose the culprit of the whole algorithm, so if you
want to try by yourself, stop reading NOW!

> Now?

NOW!! Flee, you fools!

> But now, now?

Oh, jeez, yeah.

    SPOILER ALERT!!!

The answer is: sliding window!

This is how this works: because the matching parenthesis
must form a valid parenthesis sequence, and a valid sequence is defined as:

* It is empty
* It has the form "(U)" where U is a valid bracket sequence
* It has the form "VW" where V and W are valid bracket sequences

Any valid sequence will have a consecutive number of matching parenthesis.

> ?????

Look at it this way: if you have a long parenthesis sequence and you introduce a single
unmatched parenthesis in the middle of the sequence you are splitting the sequence in 2.
Flipping any of the parenthesis in the original sequence to match the new parenthesis
will unmatch another parenthesis (because they come in pairs).

Now we have blocks of matched parenthesis followed by one or more unmatched parenthesis.
Every 2 consecutive unmatched parenthesis can be matched by flipping one or two of them,
depending on the unmatched configuration:

    ))
    ((
    )(

For the first 2 cases a single flip will do, while for the third case you need 2 flips.
Any parenthesis right after or right before a matched block can be matched either with a
consecutive unmatched parenthesis or with a parenthesis at the other side of the matched
block. In the end the idea is to find a sequence of matched blocks divided by unmatch
blocks that we can fix with the limited number of flips we are given and get the longest
sequence of matched parenthesis.

The only caveat with this problem is that it is not a local one. We cannot just some fancy
heuristic like trying to find the longest matched blocks and try to join them by flipping
the unmatched blocks. The main reason is that local information surrounding a matched or
unmatched block does not give us all the information we need to know if the block should
be part of the final solution.

Due to this we need to analyze the whole string to understand which blocks are going to be
part of the longest streak of matched parentheis. However one thing is true: the streak
must be consecutive, as this is one of the premises of the problem.

Thus, the solution is a sliding window. We'll start analyzing from the first symbol in the
string and then see how many consecutive symbols we can get by flipping the unmatched blocks,
and we will save that number. Then we will start from the second symbols, and do the same
operation, saving the number. Then the third and so on, until we actually have the maximum
number of consecutive symbols achievable with the limited number of flips we have.

Easy, right?

Remember the next function gets called after 'markedMatched' and S will contain 'X' symbols
where matched parenthesis are found.

    int findLongestStreak(string &S, int maxFlips) {
        int maxStreak = -1; /* Per problem requirements, return -1 if no possible solution found */

        for (i=0; i<S.length(); ++i) {
            int edits = maxFlips;
            int prevSymbol = 0;
            int streak = 0;

            for (j=i; j<S.size(); ++j) {
                /* Matched block */
                if (S[i] == 'X') {
                    streak++;
                    continue;
                }
                /* Found an unmatched parenthesis but
                   we are out of edits, end the loop */
                if (edits == 0) {
                    break;
                }
                /* Same parenthesis symbol twice means we only
                   need one edit to transform it into a matched
                   parenthesis:

                   )) -> ()
                   (( -> ()

                   Remember it does not matter if the parenthesis
                   is consecutive or there is a matched block in
                   between
                */
                if (prevSymbol == S[i]) {
                    edits--;
                    streak += 2;
                    prevSymbol = 0;
                    continue;
                }
                /* Special case, will only happen once in the whole
                   loop, when the unmatched parenthesis change from ')'
                   to '('. In this case we need 2 edits to match them,
                   so we can only do it if we have 2 edits left */
                if (prevSymbol == ')' && S[i] == '(') {
                    if (edits < 2) {
                        break;
                    }
                    edits -= 2;
                    streak += 2;
                    prevSymbol = -1;
                    continue;
                }
                /* Rest of cases, no edit needed */
                prevSymbol = S[i];
            }

            if (streak > maxStreak) {
                maxStreak = streak;
            }
        }
        return maxStreak;
    }

And *et voilà*, that will return the correct solution! Easy peasy! Peanuts!

> Wow!

Yeah! Wow! So you were wondering, did this awarded me my golden Codility award....no way!

> Why?

Well, problem were cycles! Not like the cycles problem found in graph algorithms. But rather
CPU cycles. My program was too slow for codility to award me a golden thingy. Dear reader,
come with me for the final journey into the realm of the pure fast. Let's optimize this shit
together!

# Of when I squeezed the jiffies out of my code...

This part was the most interesting so far for me, as I had to optimize both the algorithm
itself and also the code.

> What does that mean, dear Lord of the Pings?

When you design an algorithm there are usually 2 parts: the algorithm itself and its implementation.
Typically the algorithm is measured using the big-O notation mentioned above. That binds the algorithm
to a certain order of execution, but not to a real time of execution. That can be only measured when
the code is written in certain language, compiled with certain compiler using specific optimizations
and run in a specific computer. Nowadays we could say that using a good compiler an a modern CPU should
yield similar results independant of the compiler and the CPU (disregarding the CPU speed of course, which
will have a direct impact in execution time, and also cache levels and sizes). In general this can be
measured in CPU cycles that come directly from how the compiler lays down the instructions. Then certain
things like locality of the algorithm can speed up things by making a good use of the cache.

We won't go as far as to analyze cache usage, but I definitely had to optimize both the algorithm to
gather information that could reduce the number of iteration in succesive passes, and also the code
itself to make a more efficient use of memory accesses.

Here we go, you ready?[^6]

--------------------------
SECOND PART
--------------------------


## Algorithm optimization

So this was the thing with my algorithm. On first pass I was analyzing the input string to find the
matched blocks. While doing so I was marking the matched parenthesis with a 'X', remember? Then on the
second pass I was basically adding up those 'X' together to count the number of consecutive matched
parenthesis in a block. What if instead I saved directly the amount of matched parenthesis in a block?
Then on second pass I'd have less iterations and less additions. That should improve things a little!

To do so I'd need an extra array to store the new values. At this point I was deeming negligible memory
writes and reads compared to the number of iterations. It seems I was right in this particular case,
and I guess in average, although I didn't have time to perform a deep analysis on this.

    void markedMatched(string &S, std::stack<int> &st)
    {
        int streak = 0;

        for (int i=0; i<S.length(); ++i) {
            /* We only increase the streak when a close parenthesis is
               found in the input string, and only if it matches an opening
               parenthesis in the top of the stack */
            if (st.size() > 0 && st.top() == '(' && S[i] == ')') {
                streak += -2;
                st.pop();
            } else {
                if (streak != 0) {
                    st.push(streak);
                    streak = 0;
                }
                st.push(S[i]);
            }
        }
        /* If we had an ongoing streak, take it into account now */
        if (streak != 0) {
            st.push(streak);
            streak = 0;
        }
    }

Now we have something slightly better than 'X' in the output stack. However it is still not too
much optimized. The problem here is that if we have a lot of consecutive '()' then we will end
up with a lot of consecutive '-2' on the stack. We can do better.

> By the way, why -2?

Well, that is called variable substitution. Because we are already using positive integers for
symbols like '(' and ')', we need a different range to represent actual streaks of matched
parenthesis, and negative numbers are just perfect, as we can add them normally and we will need
just a final negation to make the result positive.

To try to consolidate all those long sequences of '-2' and similar subgroups of matched parenthesis
we just have to realize that once we finish a subgroup, there can be only a previous subgroup that
we can add up to make a supergroup, just because of the way groups of matching parenthesis are
defined. So we just need to check once we match a group, if there was a previous group streak saved
in the stack:

    void markedMatched(string &S, std::stack<int> &st)
    {
        int streak = 0;

        for (int i=0; i<S.length(); ++i) {
            /* We only increase the streak when a close parenthesis is
               found in the input string, and only if it matches an opening
               parenthesis in the top of the stack */
            if (st.size() > 0 && st.top() == '(' && S[i] == ')') {
                streak += -2;
                st.pop();

                /* We found a subgroup, just check if the stack has a
                   streak value for us that we need to add to the current
                   streak value. If that is the case, get it out of the stack
                   and add it to the current streak */
                if (st.size() > 0 && st.top() < 0) {
                    streak += st.top();
                    st.pop();
                }
            } else {
                if (streak != 0) {
                    st.push(streak);
                    streak = 0;
                }
                st.push(S[i]);
            }
        }
        if (streak != 0) {
            st.push(streak);
            streak = 0;
        }
    }

Now this function will leave the 'st' stack with a set of unmatched parenthesis interleaved with
some negative numbers which absolute value will tell us the size of the matched parenthesis in
between. Now that we have that, we just need to move the stack to a vector and then use it to
apply the sliding window, taking into account the new information. First move the stack into
a vector:

    void stackToVector(std::stack<int> &st, std::vector<int> &v)
    {
        vector.resize(st.size());
        for (int i=st.size()-1; i>=0; --i) {
            v[i] = st.top();
            st.pop();
        }
    }

Then finaly apply the sliding window algorithm on this:

    int findLongestStreak(std::vector<int> &v, int maxFlips) {
        int maxStreak = -1; /* Per problem requirements, return -1 if no possible solution found */

        for (i=0; i<v.size(); ++i) {
            int edits = maxFlips;
            int prevSymbol = 0;
            int streak = 0;

            for (j=i; j<v.size(); ++j) {
                /* Matched block */
                if (v[i] < 0) {
                    streak += -v[i];
                    continue;
                }
                /* Found an unmatched parenthesis but
                   we are out of edits, end the loop */
                if (edits == 0) {
                    break;
                }
                /* Same parenthesis symbol twice means we only
                   need one edit to transform it into a matched
                   parenthesis:

                   )) -> ()
                   (( -> ()

                   Remember it does not matter if the parenthesis
                   is consecutive or there is a matched block in
                   between
                */
                if (prevSymbol == v[i]) {
                    edits--;
                    streak += 2;
                    prevSymbol = 0;
                    continue;
                }
                /* Special case, will only happen once in the whole
                   loop, when the unmatched parenthesis change from ')'
                   to '('. In this case we need 2 edits to match them,
                   so we can only do it if we have 2 edits left */
                if (prevSymbol == ')' && S[i] == '(') {
                    if (edits < 2) {
                        break;
                    }
                    edits -= 2;
                    streak += 2;
                    prevSymbol = -1;
                    continue;
                }
                /* Rest of cases, no edit needed */
                prevSymbol = v[i];
            }

            if (streak > maxStreak) {
                maxStreak = streak;
            }
        }
        return maxStreak;
    }

And TA-DA! Code superoptimized! Right? RIGHT?

The thing is: no. I mean it is more optimized, for sure, but still not passing from
Codility Silver award. What else could we do to improve this? Well, as I mentioned
previously, we've optimized the algorithm. Now we can optimize the code itself. For
that I've measured certain parts of the code using some timing functions. A profiler
typically gives you times per function, but in this case that is not that much interesting.
It is initilly to identify which function of the 2 we have is causing the bottleneck[^7]. In
any case as you will see I ended up optimizing both, as the type of optimization was similar.

# And I was trying to use C++

Indeed I wanted to use C++ for the solution just to demonstrate my versatility in such 
indomitable language. However after a bit of profiling I realized that using a custom
implemented stack, which actually can double as a vector without any overhead, improves
the performance. Implementing a stack manually is quite easy: we just need an array and
an index into the array. Even better: we can have an array and a pointer into the array.

> Is it not the same?

Well, by using a pointer into the array we don't need to increment the index and then
index the array pointer to obtain the value. The pointer into the array will point
all the time into the right position. We just need to check the boundaries properly so we
don't point beyond the array limits.

Oh, I almost forgot: this optimization is easy because we know the upper bound for the stack size.
Otherwise we'd need to manage reallocations of the memory, incurring in memory copies, etc. But
we are lucky and we know exactly the maximum size of the stack, which is exactly the size of the
input string.

Also, and just in case you see it the code if you analyze it carefully, the stack implementation
I will use will have always one extra element to the left of the first element. This is just so
we don't have to take into account when the stack is empty. The algorithm will just pick up that
extra value, which is initialized with a proper value, and do the right thing.

Now I will show the final algorithm, the one that won the award (almost). You'll excuse me if
the step from the previous shown code to this one is to steep, but otherwise the article would
take ages!

Let's do it!

    /* Some defines for an easier to read implementation */
    #define LEFT_PAREN  '('
    #define RIGHT_PAREN ')'
    #define MATCH_PAREN  '.'

    int solution(string &S, int K)
    {
        int size = S.length();

        /* Stack buffer we will then refer from the 'st'
           variable which is a pointer into it. Please notice
           we allocate one extra byte to use it as a default
           init value for the algorithm, then we initialize that
           extra value to 0 which is useful for the algorithm (see below)  */
        int stbuf[size+1];
        stbuf[0] = 0;


        /* 'st' is the pointer into the stack, instead of an index.
           This way we avoid indexing the stack pointer to get the value */
        int *st = &stbuf[0];

        /* The real start of the stack is 'st + 1' as the first value is
           just bogus. We will use 'st_base' to determine if the stack
           is empty */
        int *st_base = st + 1;

        /* Similar optimization for the string. Not sure it improves performance
          but just for fun */
        char *str = &S[0];
        char *str_end = str + size;

        /* Streak counter, similar to the previous algorithm */
        int streak = 0;

        /* The next for loop should be familiar, it is the one used in the
           'markedMatched' function, except the loop variable and limits are
           using our new pointer based strings and stacks, and the if condition
           inside the for is reversed */
        for (; str != str_end; ++str) {
            /* Quick comment, at the beggining of the algorithm 'st' points to the
               extra value in the stack, which is initialized to 0. This way the
               if condition will be true for the first iteration, which is OK because
               we cannot have matching parenthesis with only one parenthesis */
            if (*str != RIGHT_PAREN || *st != LEFT_PAREN) {
                if (streak != 0) {
                    *++st = streak; /* Tricky bits: increment first, then dereference */
                    streak = 0;
                }
                *++st = *str;
            } else {
                streak += -2;
                st--;

                if (st >= st_base && *st < 0) {
                    streak += *st--; /* Tricky bits: dereference first, then decrement */
                }
            }
        }

        /* Same as before: if there was an ongoing streak, take it into account */
        if (streak != 0) {
            *++st = streak;
        }

        /* The below code belongs to 'findLongestStreak' function, but using the
           new stack implementation. It also has some tricky bits */
        int maxLength = 0;

        /* This is the final size of the stack, not the allocated one. We are
           counting the number of elements that are pushed in the stack, then
           calculating the end pointer for the loop */
        int st_size = st-st_base+1;
        int *st_end = &stbuf[st_size + 1];

        for (int i=0; i<st_size; ++i) {
            int length = 0;
            int edits = K;

            /* Just to make things clear, we use stbuf directly here
               to avoid grabbing the address for 'i+1' below if it is
               not needed. This is basically checking the 'i-1' position,
               because 'st' actually starts at stbuf[1]. If the previous
               position is a matched parenthesis we can skip as the previous
               sliding window should have already taken it into account. This
               is true since finding a valid matched parenthesis sequence at 'i'
               when there is another matched parenthesis sequence at 'i-1' should
               concatenate both values, as we are looking for the longest streak */
            if (stbuf[i] < 0) {
                continue;
            }

            /* Initialize 'st' to start applying the sliding window */
            st = &stbuf[i+1];

            /* Same loop as in the original function but using our new stack implementation */
            for (int prevBracket=0; st!=st_end; ++st) {
                /* Position contains a matched parenthesis count (in negative),
                   make it positive and add it to the current length */
                if (*st < 0) {
                    length += -*st;
                    continue;
                }
                /* Ops, we found an unmatched parenthesis but we are out of edits, so
                   break the loop and analyze the result */
                if (edits == 0) {
                    break;
                }

                /* Lucky us! We still have edits left. In this case we found the same
                   bracket twice, either '((' or '))' so we only need 1 edit to fix it */
                if (*st == prevBracket) {
                    length +=2;                /* By editing one parenthesis we have 2 more matched parenthesis */
                    edits--;
                    prevBracket = MATCH_PAREN; /* And remember we've matched it, so we don't try to match it again */
                } else if (prevBracket == RIGHT_PAREN && *st == LEFT_PAREN) {
                    /* In this case we found two different unmatched parenthesis,
                       so ')(', we need 2 edits to match them, if we don't have that many
                       we are done with this window */
                    if (edits < 2) {
                        break;
                    }
                    /* Otherwise same case as in the 'if' part, except we substract 2 edits */
                    length +=2;
                    edits -= 2;
                    prevBracket = MATCH_PAREN;
                } else {
                    /* For the case when we don't have a previous parenthesis, so only
                       the first time we find an unmatched parenthesis in a sliding window */
                    prevBracket = *st;
                }
            }

            /* Analyze the length and see if it is a maximum */
            if (length > maxLength) {
                maxLength = length;
            }

            /* If we've reached the last position no point on continuing processing */
            if (st == st_end) {
                break;
            }
        }

        return maxLength;
    }

Well! Now it is! Yeah! Hooray!!! We've optimized the brains out of that glitch!

> For real??

Ha! Nop....

> Nop??

NOP[^8]

According to Codility, we still get a Silver award. Whaaaaat!?[^9]

# About pragmatism

And here we are, my dear readers. Such a long way and still we are not home. We aimed to be gods and reality has
crushed our very dreams of fame and wonder. Long ago forgotten is our pride and the upbecoming scent of roses.....

> Cut the shit, man!!

Yeah, sorry. Just got lost in my own verbiage. My apologies.

You know what? It was really NOT enough. So I had to use the power of the O! More specifically the *-O3* option that
comes with the GCC compiler. This is the thing. In Codility, when you choose a language for the challenge, you can
see at the bottom the compiler used to compile your code. In my case for C/C++ it is GCC 4.8.3 if I recall correctly.
So I figured I could use some compiler specifics. The question was, of course, how to pass this flag to the compiler
when I actually didn't have access to the Makefile or compiling script.

> Pragmatism!

Indeed! Did you know there is a *#pragma* directive that allows you to request certain level of optimization in GCC?
Me neither. Here it follows the life saving line:

    #pragma GCC optimize ("O3")

Now we got the Gold, baby!

Hope you've enjoyed the article. I must confess it's taken more time for me to write the article than to write the
code! But I found the experience a nice learning one, and I thought I should share it.

Keep up the good work!

------------------

 [1]: http://www.codility.com
 [2]: https://codility.com/programmers/task/brackets_rotation/

 [^1]: Only me or the this 2 syllables 'tit' and 'anium' sound funny to anybody else?
 [^2]: Yeah, well, actually there are other challenges in Codility that are REALLY crazy, but I have to sell it, right?
 [^3]: Yeah, sure!
 [^4]: If you are not familiar you can check one of many articles explaining it, like this one: http://web.mit.edu/16.070/www/lecture/big_o.pdf
 [^5]: If you get less than that number, you are doing something really wrong!
 [^6]: Still reading at this point? My congratulations! And condolences. Yeah, who figures!
 [^7]: Quick answer: the first function, although for certain cases with longer number of swaps, the second is also taking some time.
 [^8]: NO Pun intended....
 [^9]: Read on for a surprising turning of events!
