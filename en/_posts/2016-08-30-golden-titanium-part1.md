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

Recently I was sailing the internet stopping at islands of unspeakable names, when I ran
aground on the most peculiar island I had ever seen on my numerous sea adventures: [Codility][1].
A seemingly paradisiacal oasis for programmers that challenged my senses and my understanding
of fun and logic.

While romping at this site like a burglar in an abandoned gold mine, I saw it: THE CHALLENGE. Well,
the upper case letters were not there, buts its Unicode lower case counterparts were. A new challenge
had started just few hours before, and it went by the name of Titanium[^1]

There were other tests, yes, but they belonged to the past, their petty trials paled in comparison
with this new behemoth that questioned the very nature of the human mind[^2].

And I was the chosen one, erected to tackle the Titanium Challenge!

# Baby steps

So what was all this fuzz about? 

[THIS][2].

Basically the aforementioned challenge consisted on writing a
program to solve a problem. The language of choice could be one of many options available,
including C and C++, which I'm proficient in.

The problem? Parent matching.

> Parent matching?

Well, sorry, parenthesis matching. I was just trying to shorten the story[^3]. The problem consisted
on matching a sequence of parenthesis given as an input, along a maximum number of swaps that could be
performed on the input string. The swaps could be used to maximize the matchings. The implemented
function should return correctly the maximum number of matched parenthesis that the procedure could
achieve by using the given number of swaps. It is important to note that the function should return
the maximum number of matched parenthesis, and not matched pairs (which in the end turns to be the
number of pairs multiplied by 2).

> How can you tackle such an overly complicated task?

Good question! Rather easily. At least the first part, the parenthesis matching. It turns out that apart
from a correct output, the function must also comply with space and time complexity constraints (big-O
notation). Both were bound by O(N), meaning it should run on linear time[^4] and use an amount of
memory linearly proportional to the number of input parenthesis.

So let's tackle the first part first.

# Parenthesis matching or how much did I miss my stack

How do you match parenthesis that must be nested? The answer is a stack. I hope you are familiar with
what a stack is, otherwise the rest of this article may melt your brain a bit. With a simple loop
and a stack from the C++ STL we can determine whether the input parenthesis are matched or not:

```cpp
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
```

> That is great!

Well, yes, but not too useful. From the zillion combinations we may receive as an input only
a few will be well formed nested parenthesis expressions, but this function may be useful for
something else. What if we mark which parenthesis have matches? For that we will need to remember
the position of the opening parenthesis, so we can mark that position also as matched, so we will
use 2 stacks, one for matching the parenthesis, and the other one to save the positions:

```cpp
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
```

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

Due to this we need to analyse the whole string to understand which blocks are going to be
part of the longest streak of matched parenthesis. However one thing is true: the streak
must be consecutive, as this is one of the premises of the problem.

Thus, the solution is a sliding window. We'll start analysing from the first symbol in the
string and then see how many consecutive symbols we can get by flipping the unmatched blocks,
and we will save that number. Then we will start from the second symbols, and do the same
operation, saving the number. Then the third and so on, until we actually have the maximum
number of consecutive symbols achievable with the limited number of flips we have.

Easy, right?

Remember the next function gets called after 'markedMatched' and S will contain 'X' symbols
where matched parenthesis are found.

```cpp
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
```

And *et voilà*, that will return the correct solution! Easy-peasy! Peanuts!

> Wow!

Yeah! Wow! So you were wondering, did this awarded me my golden Codility award....no way!

> Why?

Well, problem were cycles! Not like the cycles problem found in graph algorithms. But rather
CPU cycles. My program was too slow for codility to award me a golden thingy. Dear reader,
come with me for the final journey into the realm of the pure fast. Let's optimize this shit
together!

For that you'll need to read the continuation in a follow-up article!

> Cliffhanger!

**Cliffhanger!**

------------------

 [1]: http://www.codility.com
 [2]: https://codility.com/programmers/task/brackets_rotation/

 [^1]: Only me or the this 2 syllables 'tit' and 'anium' sound funny to anybody else?
 [^2]: Yeah, well, actually there are other challenges in Codility that are REALLY crazy, but I have to sell it, right?
 [^3]: Yeah, sure!
 [^4]: If you are not familiar you can check one of many articles explaining it, like this one: http://web.mit.edu/16.070/www/lecture/big_o.pdf
 [^5]: If you get less than that number, you are doing something really wrong!
 [^6]: Still reading at this point? My congratulations! And condolences. Yeah, who figures!
