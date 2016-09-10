---
title: Developing the improbability engine
layout: post
image:
  feature: dontpanic.jpg
tags:
  - Programming
---

# Well, what?[^1]

Hey! I'm back! Thanks, thanks, don't need to applaud. I know, I know. It's been literally months
and suddenly I'm publishing more often!I've been extremely busy these last months, some good things
and some bad have happened during this period. Luckily the good ones are kicking the bad ones' asses!

But finally I'm back and I will try to get regular! [^2]

I'm doing so many things lately that I don't actually have much time to edit this blog as often as it
deserves, but I will try to at least update it ever 2 or 3 months, just so you know.

# Preface[^6]

\***drum roll**\* Ladies and gentleman, I'm proud to announce to the world that I, Roberto Cano,
am currently writing a 3D engine \***standing ovation**\*

Yep. That's it. End of post![^3]

This is actually not what's kept me so busy lately, but rather other projects that belong another blog's
realm [^3]. However that's what this post is about: how I'm writing a 3D engine!

I've been interested in graphics and games programming since I was a little toddler[^4]. I got my
first computer, a Spectrum +2A 128K, when I was 10 years old. 2 years before that I started flirting
with my other big passion: playing videogames. I received an Atari 2600 videoconsole for my birthday
and I couldn't be happier! Then when I got my first computer I mainly wanted to do 2 things: play
games and write them!

I tried to write some stuff using one of the most powerful languages in the galaxy: BASIC. If you
don't even know it, that is right. Very right. You should know C or C++, Go, Python or even Java,
Swift, or JavaScript. At the very least, Pascal to learn proper programming. BASIC was nice at its
time, but it's no use any more.

> But sir, you learned BASIC first, and you are the most amazing programmer I know!

I know, little Tommy. And you are right, BASIC gave me an understanding of a simple programming
language and allowed to fool around a bit. It also structured my mind so when I saw C for the
first time I wanted to take my eyeballs out of my eye sockets and feed the piranhas. Yes, C
looked horrible to me after learning BASIC, but hey, those were the 90's!

After that naive attempt at writing a game without even knowing of the existence of assembler,
I just diverted my efforts into learning programming in general. Later on during my university
career I retook graphics programming for a while and wrote my own software engine: using
direct framebuffer access and nothing more, I wrote with a couple of friends an engine from
scratch.

From scratch!

> ...

I will repeat it just in case.

**FROM SCRATCH!**
{: style="font-size: 120%" :}

> That sounds difficult, sir!

Well, it is, and it is not. It is just not the most efficient way of doing things. But it was a lot of fun.
Remember those were the times of Quake and ID Software, and software rendering was still a thing,
and assembler ruled the game scene. So we tried to learn the basics: Bresenham algorithm,
perspective correction, flat and gouraud lighting, BSPs, portals. However for some reason I got
pre-empted again by one of the most important events in my life: I started working in a company!

And the work was completely unrelated to games, although it was really amazing, writing real-time
software for a radar company in Spain!

And then now that I'm approaching my golden years and retirement lies ahead of me, my youth seems
nothing but a summer daydream that melted away like a strawberry ice cream left alone in the sun[^5],
so I've decided to write my own engine!

> Why?

Why not?

> Oh, ok...

The thing is that it is fun, I'm learning a lot and I may even try to write a game some day!

# To the point...or should I say vertex

I started writing the engine around February this year. I had some code I was working on before,
which I also used to write an entry in this blog about OpenGL. I used that code as starting point
and then I continued adding features that I dimmed interesting. This entry is about the overall
work I've done until know and the things I've learned on my way there. If I feel like it[^7] I may
write some article about some specific technique I've implemented.

In any case, **BIG DISCLAIMER**:
---
    I have almost near to no experience in writing an engine, graphics programming or videogame
    development, so take my words as what they are: amazing! But unexperienced. It may help you
    though to ally some doubts you may have or some technical problem you may find.
---

# Hello, 3D world!

First of all you should know that all the code I'm going to refer to during this article is available
in my GitHub repo [3Dengine][1]. I've been adding a lot of stuff so I may simplify the code here to
make it more palatable.

If you want a very first introductory tutorial on setting up a GLFW and OpenGL in Mac OS X you can
find my previous tutorial [here][2].

Now, where to start? I already had a Window with 


------------------

 [1]: http://github.com/gabr1e11/3Dengine/
 [2]: http://www.robertocano.es/en/osx-and-opengl-3-2/

 [^1]: "What" what?
 [^2]: Do NOT trust me, I may disappear again like the subtle breeze of summer days that flirts with your naked neck and then flees away
 [^3]: Ha! You wished!
 [^3]: Oh yes, my friend, I DO have another blog. Can you find it?
 [^4]: ...of 10 years old, but a toddler, OK?
 [^5]: Yeah, ok, I'm not THAT old. For real! Ok, also not that young any more...
 [^6]: You know, you can skip this section, go to the next for the real meat! (and yes, this footnote is out of order, duh!)
 [^7]: Because, you know, this is my blog and I do whatever the *f* I want...





