---
title: Mastering the improbability engine
layout: post
image:
  feature: dont-panic.jpg
tags:
  - Programming
---

# Well, what?[^1]

Hey! I'm back! Thanks, thanks, don't need to applaud. I know, I know. It's been literally months
and suddenly I'm publishing more often! I've been extremely busy these last months, some good things
and some bad have happened during this period. Luckily the good ones are kicking the bad ones' asses!

But finally I'm back and I will try to get regular! [^2]

I'm doing so many things lately that I don't actually have much time to edit this blog as often as it
deserves, but I will try to at least update it ever 2 or 3 months, just so you know.

This post is about how to get a job in the videogame industry when you are a complete outsider. If you prefer
to skip my usual digression, you can jump directly [here](#how-to-become-a-videogame-developer-when-you-are-already-35)

# Preface

As life wants it, this post was originally destined to be a _How to write your own 3D engine in
OpenGL for dummies_ post. I was gonna rant about the challenges and subtleties of writing an engine
in C++ for the OpenGL API while keeping it multi-platform and multi-API. It was also going to showcase
some nice techniques I had learned in the process.

However I'm not going to do it. No sir. No, no, no, no.

And 'Why?' would the sharp reader of this blog wonder astonished.

> What?

Ok, perhaps I'm overestimating the audience of my blog. In any case the reason is simple, although not so
much my answer which, as usual, will be given in a roundabout manner.

# When I was a kid

Oh, yeah. We are starting from the beginning.

It was 1992. The year that the Atari 9600, my dear Atari, was finally discontinued. Achy Breaky Heart, the catchy
song of the father of Miley Cyrus[^3], introduced Country music to a whole new generation. Definitely not mine.
And Aladdin, the Disney movie, taught us how to find our true love by lying, deceiving and using a secret dark
power hidden in a lamp. Neat!

At the same time, I, a young underdeveloped developer, was made the recipient of a wonderful present: a Spectrum 128K +2A
computer with incorporated tape reader!! I was ecstatic. Since I was 10 I wanted one of those fancy machines for me, after
seeing my cousin handling one of those beauties!

When I got it, the first thing I tried was a game[^4]. Then another game[^5]. And then, after learning a bit of BASIC programming,
I tried to write my own game!! In BASIC! Using ASCII! Never heard of system routines, graphic mode or assembler. Who figures!

> Wow, master! Did you succeed in such a grandiose task?

No. But remember Timmy, I'm the eloquent fella around here.

> Yup!

So I tried, but never really managed to make anything interesting. However my passion for videogames stuck with me
like used chewing gum sticks to a shoe sole after you step on it on the street.

> Yuck!

Let's fast forward many years into the future. Let's time travel to 1998! I started university at the _Universidad Autónoma de
Madrid_, and during the 3rd year I picked a really interesting course: graphics programming. With a couple of friends we
started writing a software 3D engine. Those were really good times. Just with access to the framebuffer we started
implementing polygon rendering, flat and Gouraud lighting, and even texture mapping! It was lovely. We even managed to import
Quake 3 world models and navigate through them in our engine! It was amazing!! Later on we tried to implement a BSP compiler[^6]

However the pressure I had with all the other courses and the need to finish the career to start working and start earning good money
crippled my dream of becoming a game developer. Game developer jobs were sparse in Spain, not well paid, with many working hours,
barely any recognition...

> So basically the same as today for any game developer job ever...

Well, yes, but that's not the point! Things were really bad in Spain at the time, and I didn't know a single bit of the overwhelmingly
awesome English I know today, so going abroad to work was out of the question.

The end result was that I started working in a radar company, I enjoyed myself and the money....and kind of forgot about my
childhood dream!

# Enter 2015

Time travel! Again! This is one of the most exciting posts ever!

> If you say so...

It was 2015, and I was trying to figure out what to do with my professional life. After 12 years of working with C, C++,
Linux, embedded environments and stuff like that, I was starting to get a bit bored of the same drill. Security systems were
starting to catch my attention. However I was always missing something. I'm a very visual person and security systems are
all about system programming where UI or user interaction is sparse. Also I was missing the feeling of knowing that somebody
was interacting with my software in a meaningful way. In security, if your product is very good, the user never notices it!
Then suddenly an idea crossed my mind.

> To stop writing annoyingly lengthy post that seem to never end?

No. Good try. But no. Could I, perhaps, in the peak of my game, perform a complete career change and make my childhood dream
of becoming a game developer come true? I decided I had to try. I had to give myself the opportunity to at least try. So
I put all my attention into it and started working on a plan.

# How to become a videogame developer when you are already 35

The big question for me was: how can I capitalize on my expertise to steer my career into the direction I want? I knew nothing
about design, professional game engines, UI or monetization. My expertise was in low-level systems, Linux, C++ and a life-long
passion for programming. I also had some rare qualities:

- I love low-level stuff at assembler level as well as very high-level stuff like 3D APIs and complex systems. Give me an engine,
  an OpenGL API and some low-level optimizations to work on and I'm happy!
- I'm a developer. I'm social. I'll say it again: I'm a developer and I'm really social. I didn't know but apparently that
  is a rare combination. Anyhow I'd like to think that less and less nowadays. But it is true I can lock myself in a room and write
  code for 3 days and then get out and do a presentation in front of 50 people. I love both things!

With all this in mind I decided that the way to go was the following:

- I need to demonstrate my skills in C++ and low-level knowledge, so I will write an engine in C++ with OpenGL
- I need also to demonstrate my multi-platform/multi-architecture skills, so my engine will compile for Windows, Linux and Mac.
  It will also have an architecture that allows different APIs to be added, like DirectX
- I need to capitalize on my social skills, so I will attend major or interesting videogame conferences to meet people
  and understand how far I am from becoming a videogame developer

So that is what I did. For a year and a half. I started writing my own C++ engine. You can find the sources in my GitHub. It was
quite a challenge, as I had never done anything like that. But it was an amazing experience, and quite a lot of fun!

It indeed compiled for Windows, Mac and Linux. I implemented model and texture loading and rendering, Blinn-Phong lighting, HDR,
procedural geometries, Bloom effect, Shadow mapping and some other shaders effects.

I also went to several conferences: GDC Europe, Unite, Respawn, Screenshake. I started reading more news about videogame development,
subscribing to videogame jobs websites, contacting people to see what kind of opportunities were out there. With all this work, and
1 year and a half into my plan, I got the first tangible outcome: an interview at Guerrilla Games, in Amsterdam. Guerrilla Games!!!!!

> Guerrilla Games!!!!!

Guerrilla games!!

> I heard you, stop shouting!!

I was incredibly excited. I had worked really hard for a long time, almost every day in the evening sitting for a couple of hours
writing my engine, learning about techniques, reading papers, etc... And finally I had the interview of my life!! This interview,
by the way, came through somebody I knew at GDC Europe. Never underestimate the power of networking!

I prepared for the interview as best as I could and there I went, not knowing exactly what to expect.

The guys at Guerrilla were really kind to me. They welcomed me and then brought me to the interview room. Two technical leads
were going to interview me. I was already thinking that I had a real chance to make it into one of the most important AAA studios
in the world! After 15 minutes of interview we were done: I wasn't going to make it.

> What??

It was eye opening. They were really nice to me and after the first 15 minutes they spent another 45 trying to see if they could
fit me anywhere in the company, or in any other company in Netherlands, but it didn't work.

> What happened?

The gist of it is that I was lacking a lot of experience for the kind of games they do. AAA games are no joke. The amount of complexity
in those games is incredibly high. Until then, I never thought about it: 300 people working for about 5 years ON A SINGLE PRODUCT, where
all parts are interconnected (models, animations, sound, programming, effects, etc...). They definitely liked my attitude, but there
was no way I could add immediate value to the company.

After a sad goodbye and an invitation from their side to try again in a couple of years, I went back home and started reconsidering my plan.

What I had learned was that, in general, my kind of expertise and what I was trying to sell was quite specific. Only studios using
their own engines or technologies would look for somebody with that expertise. But it is too risky to hire somebody without
previous videogame experience, so it seemed like I had hit a roadblock. What to do?

After almost 1 month considering my options, the idea of learning Unity popped into my mind. That way I could access a wider range
of companies, but I was afraid that learning Unity could dilute my C++ expertise, and that I would be competing against a myriad of
other developers and designers. However it seemed really appealing to to me the idea of developing a full videogame. Compared to
doing everything from scratch, using Unity (or Unreal) could allow me to learn another level of videogame programming, and not focus
on the little nitty-gritty details only.

So I decided to do it. Fortunately at the same time, a very good friend of mine that had never done anything with videogames,
discovered a passion for pixel art and started to groom the idea of developing a rogue-like game. We discussed about it,
and the idea started to shape in our minds. At that moment I decided that having a project was the best way to learn what is
needed to develop a game with Unity. Otherwise it can turn into a theoretical exercise on how to develop a game that can
let you stranded.

We started in January 2017 and had been advancing at quite a good pace, until the event happened!!

> The event? The end of the world? The new House of Cards season was released?

No, my friend. During this time I had sent a lot of CVs to different companies around Amsterdam, and also had some interviews, all of
them with the same result: they didn't hire me because I had no experience in videogames. But I kept trying while steering my plan into
learning Unity. Finally in February another contact I had from GDC Europe/Respawn wrote me to tell me that his company was hiring. Urgently. Urgently meaning more chances for me to perhaps enter without previous videogame experience.

If I succeeded it would mean to leave the city I love and all my dear friends that live here, in Amsterdam. But it would also mean
that I could fulfill my life-long dream of becoming a game developer! Choices, choices...

Finally I decided to apply. After quite a tough selection process including an offline test and a live-test with 2 technical leads,
they came back to me with the good news: they wanted me there!! I couldn't believe it!! I think I haven't been this happy in a long
time. You know, tears and stuff! I made it! I think the 10 years old kid living inside of me is the happiest kid in the world right now!

> Literally?? Do you really have...

No, no. That would be weird. Really weird! Where did you say you were from, Timmy??

Never mind. The thing is that I'm moving to Barcelona this month to start working in one of the most amazing companies I've known of:
Social Point. From everything I know about them, I think it is going to be one hell of a life experience. Personally, I'm closing a
chapter of my life and opening a new one. I'm excited, happy, sad, fearful, full of energy, positive and a lot of other emotions that run through my mind.

It is good when life taps you on the back.

Very good.

# Summary of good practices

So what steps should you follow to become a game developer? Honestly, I have no clue. I can see that each case is different, and
your previous expertise, how you are, what you want and many other factors will definitely condition the way you need to
approach this journey. However I will try to give you some generic advise here.

## Go social

For me the first and most important thing before, during and after becoming a game developer is: socialize. Make friends, meet people,
go places. Get out of your comfort zone and try to experience new things. Experiences are invaluable. Even the bad ones. Be curious
about other people work, lives and opinions. Go to conferences. Go to conferences. Yeah, go to conferences. Not only the big techie
ones like GDC. Also the alternative ones. The ones that open your mind and fuck your brain...in a good way.

By the way, one last tip to go social. If you go to conferences, go alone. Or if you go with somebody else, split and go different
ways for a while. We, humans, are not made to spend more energy than we need, and having an accomplice at a conference may limit
your openness.

Also going social means to keep your friends close. They are the ones that will keep you sane when things go bad, and the ones that
will encourage you to keep trying.

# Learn, learn, learn

Never stop learning. Even if it seems it is not very useful at the moment. Don't get me wrong, you need to reassess what you are
doing to understand if it is aligned with your goal. But don't get too overwhelmed with the thousands of things you need to learn
to make it into the game industry. Pick one. The one that you like most and seems more in line with the kind of work you want to do. And
learn about it. Then pick the next. There is no other way. You could be surprised sometimes how skills you deemed useless may come
in handy during an interview or test.

For example during one of my previous interviews there was a test with 2 exercises: writing a shader to draw some kind of procedural
character and emulating an ARM instruction in C. Because I had been working on my engine with OpenGL and shaders I was able to
tackle the first one. Because I took some interest in emulators some years ago I could tackle the second. I never thought my
emulation interest could come in handy!

I have many other interests, completely unrelated. Who knows when they will come in line to help me.

# Work hard

This last 2 years have been all about working a bit everyday. Some days I was working on my engine from 19:00 to 00:00, some
other days from 21:00 to 23:00, some days I just went with my friends to have a drink. I never lost sight of my goal, or the fact
that I had to work on it, but I was also really conscious that I'm a human being and I need some space and rest, and people, and fun.
Never forget that the main purpose of your life is to be happy. You decide how to achieve that, but never lose sight of that very
true purpose: happiness.

Then try to balance your life so you can work hard on the goals that make you happy, and try to spend less energy on the things
that are not important. Then never forget that YOU are important. Your friends and family are important. Relationships and love
are important. And health. Sway things to the side you need, but never replace completely one thing for another.

# Capitalize in your expertise and skills

Try to realize what your strong points are. We all have things we are good at, and things we are not so good at. Try to understand
what those things are and try to build upon them. If you are not a good developer but you like music, perhaps you can be a videogame
musician, or if you like story telling, perhaps you can write videogame scripts. If you like the technical side try to understand which
of your traits will work better in that environment.

# Be ready for a negative

One more important thing you need to learn: you may not make it. Ever. I had this emblazoned in my mind. Because it was true. There
is no law in the universe that says that if you try hard enough you will make it. It may never happen. You may have the right to try[^7],
but there is no way to know if you will eventually make it. I had given myself a ballpark timeframe to stop trying. Around 4 years to
understand if I could really make it or not. If things were not going well I would quit and dedicate my efforts to other things.

Remember it is not about failure. It is about not wasting your energy. If after 4 years, for example, things were still not looking
clear to me, perhaps there was no point on keep trying. This is very subjective, but the main point is that trying forever, unless
it makes you happy, may mean that you are not ready to give up. Sometimes giving up is a good thing. It frees your mind to do other
things that make you happy, which is the main purpose of your life.

# Summarizing the summary

Things to keep in mind:

- Life is about happiness
- Happiness is not a goal, is a temporary state
- Find what makes you happy and steer your life towards that
- Manage your energy appropriately and never forget about the important things: yourself, friends, family, having fun, resting, living...
- Try to achieve your goal. If you keep trying and it does not happen, choose something else: the world is full of amazing things to do

The second item is very important. Happiness is not something you unlock one day and then stays forever: it comes and go. You need to
work hard to keep happiness close to you, and it is not always possible. Something that makes you happy today may not make you
happy in 20 years time, or even 1 month time for that matter. You need to reconsider and analyze if you want to keep that in your life,
or it is costing you too much energy. It is a constant process.

But it can be one hell of a ride!

# Lightening the mood!

Oh, wow! Ok, that was heavy speech back there! I realize that these are more like life-managing tips, rather than how to become
a game developer tips, but I think they are really inter-related. I've seen many people trying to get there in the videogame
industry, and losing themselves in the process. You cannot dedicate all your time and effort to only one thing, because if
that thing fails it can let you completely stranded.

In any case take all this things with a grain of salt. I'm no guru. I'm just sharing what my experience has been while trying
to get into the game industry, and I think it may be useful to somebody out there!

See you soon!

---

[1]: http://github.com/robercano/3Dengine/
[2]: http://www.robertocano.es/en/osx-and-opengl-3-2/

[^1]: "What" what?
[^2]: Do NOT trust me, I may disappear again like the subtle breeze of summer days that flirts with your naked neck and then flees away
[^3]: Yeah, well, who remembers the father after what his gifted kid has given to the world!
[^4]: Pictionary
[^5]: Teenage Mutant Ninja Turtles....a classic!
[^6]: Binary Spatial Partitioning Trees...a classic!
[^7]: Sadly not everybody in the world has this privilege
