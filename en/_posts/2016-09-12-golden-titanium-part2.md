---
title: Golden titanium alchemy - Optimization (2/2)
layout: post
image:
  feature: Codility.jpg
tags:
  - Programming
---

# De-introduction

This is a follow up on [this previous article][1]. Go there if you haven't yet.

# Of when I squeezed the jiffies out of my code...

This part was the most interesting so far for me, as I had to optimize both the algorithm
itself and also the code.

> What does that mean, dear Lord of the Pings?

When you design an algorithm there are usually two parts: the algorithm itself and its implementation.
Typically the algorithm is measured using the big-O notation mentioned above, which binds the algorithm
to a certain order of execution, but not to a real time of execution. That can be only measured when
the code is written in certain language, compiled with certain compiler using specific optimizations
and run in a specific computer, with a particular CPU[^1].Nowadays we could say that using a good compiler
and a modern CPU should yield similar results, but specifics like CPU speed, cache levels and sizes, instruction
set, etc... can have an impact on the final measured time. For example things like locality of the algorithm
can speed up things by making a good use of the cache.

We won't go as far as to analyze cache usage, but I definitely had to optimize both the algorithm to
gather information that could reduce the number of iteration in successive passes, and the code to
make a more efficient use of function calls and memory accesses.

Here we go, you ready?

## Algorithm optimization

So this was the thing with my algorithm. On first pass I was analyzing the input string to find the
matched blocks. While doing so I was marking the matched parenthesis with a 'X', remember? Then on the
second pass I was basically adding up those 'X' together to count the number of consecutive matched
parenthesis in a block. What if instead I saved directly the amount of matched parenthesis in a block?
Then on second pass I'd have less iterations and less additions. That should improve things a little!

To do so I'd need an extra array to store the new values. At this point I was deeming negligible memory
writes and reads compared to the number of iterations. It seems I was right in this particular case,
and I guess in average, although I didn't have time to perform a deep analysis on this.

```cpp
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
```

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
in the stack, if so add it to the current streak and remove it from the stack:

```cpp
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
```

Now this function will leave the 'st' stack with a set of unmatched parenthesis interleaved with
some negative numbers which absolute value will tell us the size of the matched parenthesis in
between. Now that we have that, we just need to move the stack to a vector and then use it to
apply the sliding window, taking into account the new information. First move the stack into
a vector:

```cpp
void stackToVector(std::stack<int> &st, std::vector<int> &v)
{
    vector.resize(st.size());
    for (int i=st.size()-1; i>=0; --i) {
        v[i] = st.top();
        st.pop();
    }
}
```

Then finally apply the sliding window algorithm on this:

```cpp
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
```

And TA-DA! Code super optimized! Right? RIGHT?

The thing is: no. I mean it is more optimized, for sure, but still not passing from
Codility Silver award. What else could we do to improve this? Well, as I mentioned
previously, we've optimized the algorithm. Now we can optimize the code itself.

In order to do that I had to analyze the timing of the different part of the algorithm.
You can do that using your favourite profiles or instrumenting the code yourself. By doing
so I learned 2 things: which function of the 2 we have is impacting the performance more[^2],
and which specifics bits of code are bringing down performance.

# And I was trying to use C++...

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

Also, and just in case you are a picky programmer that checks every dot and comma in the code,
the stack implementation I will use has one extra element to the left of the first element.
This is just because in the algorithm we are looking at position 'i-1' for the iteration 'i',
so by having that extra element we don't need to have an extra flag that will be checked at
every iteration to know if 'i==0', saving us some precious cycles[^3].

Now I will show the final algorithm, the one that won the award (almost). You'll excuse me if
the step from the previous shown code to this one is too steep, but otherwise the article would
take ages!

Let's do it!

```cpp
/* Some defines for an easier to read implementation */
#define LEFT_PAREN  '('
#define RIGHT_PAREN ')'
#define MATCH_PAREN  '.'

int solution(string &S, int K)
{
    int size = S.length();

    /* Stack buffer for the stack data. We will point to this
       buffer with the 'st' stack pointer. Please notice
       we allocate one extra byte to use it as a default
       initial value for the algorithm, then we initialize that
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
        /* Quick comment, at the beginning of the algorithm 'st' points to the
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
               break the loop and analyse the result */
            if (edits == 0) {
                break;
            }

            /* Lucky us! We still have edits left. In this case we found
               the same bracket twice, either '((' or '))' so we only need
               1 edit to fix it */
            if (*st == prevBracket) {
                length +=2;                /* By editing one parenthesis we have
                                              2 more matched parenthesis */
                edits--;
                prevBracket = MATCH_PAREN; /* And remember we've matched it, so
                                              we don't try to match it again */
            } else if (prevBracket == RIGHT_PAREN && *st == LEFT_PAREN) {
                /* In this case we found two different unmatched parenthesis,
                   so ')(', we need 2 edits to match them, if we don't have that
                   many we are done with this window */
                if (edits < 2) {
                    break;
                }
                /* Otherwise same case as in the 'if' part,
                   except we subtract 2 edits */
                length +=2;
                edits -= 2;
                prevBracket = MATCH_PAREN;
            } else {
                /* For the case when we don't have a previous parenthesis,
                   so only the first time we find an unmatched parenthesis
                   in a sliding window */
                prevBracket = *st;
            }
        }

        /* Analyse the length and see if it is a maximum */
        if (length > maxLength) {
            maxLength = length;
        }

        /* If we've reached the last position no point
           on continuing processing */
        if (st == st_end) {
            break;
        }
    }

    return maxLength;
}
```

Well! Now it is! Yeah! Hooray!!! We've optimized the brains out of that glitch!

> For real??

Ha! Nop....

> Nop??

NOP[^4]

According to Codility, we still get a Silver award. Whaaaaat!?[^5]

# About pragmatism

And here we are, my dear readers. Such a long way and still we are not home. We aimed to be gods and reality has
crushed our very dreams of fame and wonder. Long ago forgotten is our pride and the upcoming scent of roses.....

> Cut the shit, man!!

Yeah, sorry. Just got lost in my own verbiage. My apologies.

You know what? It was really NOT enough. So I had to use the power of the O! More specifically the _-O3_ option that
comes with the GCC compiler. This is the thing. In Codility, when you choose a language for the challenge, you can
see at the bottom the compiler used to compile your code. In my case for C/C++ it is GCC 4.8.3 if I recall correctly.
So I figured I could use some compiler specifics. The question was, of course, how to pass this flag to the compiler
when I actually didn't have access to the Makefile or compiling script.

> Pragmatism!

Indeed! Did you know there is a _#pragma_ directive that allows you to request certain level of optimization in GCC?
Me neither. Here it follows the life saving line:

```cpp
#pragma GCC optimize ("O3")
```

Now we got the Gold, baby!

Hope you've enjoyed the article. I must confess it's taken more time for me to write the article than to write the
code! But I found the experience a nice learning one, and I thought I should share it.

You can always browse through my Codility repo for the Titanium challenge [here][2]. There are several snapshots
that may reflect what I've explained here. You can also browse any of my other projects.

Keep up the good work!

---

[1]: {{site.url}}/en/golden-titanium-part1/
[2]: http://github.com/robercano/codility/tree/master/titanium

[^1]: Cosmic rays can also influence your results! Beware!
[^2]: Quick answer: the first function, although for certain cases with longer number of swaps, the second is also taking some time.
[^3]: Sorry, no Gollum joke here!
[^4]: NO Pun intended....
[^5]: Whaaaaat!?
