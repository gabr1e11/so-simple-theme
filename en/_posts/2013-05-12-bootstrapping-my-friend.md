---
title: Bootstrapping my friend
author: rcano
layout: post
image:
  feature: E328I01.png
tags:
  - Programming
---

Het is lang geleden! It's been a while since I don't write here and the reason
is...vacation! I've been traveling around the world (almost literally as I've
been enjoying of Cambodia and Japan in less than a month) and I've
been successfully disconnected of my everyday routine. Now that I'm back I'm
really struggling to get back at work and my OpenGL learning, but as a
compensation I've been toying around with several ideas that I was curious
about:

  * On one hand I've been investigating about implementing Wireshark plugins
    through its Lua interface to help analyze DVB Simulcrypt traffic captures,
which is quite useful in my job. This I did while helping in the integration of
our systems with one of our customers, and it proved to be extremely helpful.
The Lua interface for Wireshark is actually not really intuitive, and I needed
some examples developed by another colleagues to get a grasp on it, but I
finally I came up with a clean and easily extensible architecture that will
allow me to add more plugins in the future. If I have enough time I'll post some
information on how this works to add my personal bit to the scarce information
that you can Google around about the topic.

  * On the other hand I've also had a grasp on FFMPEG filters as a consequence
    of some POC needed for our research about video. In this case I basically
took the *drawtext* filter and I stripped it out of all the unneeded code until
I had a minimum plugin that I could easily tweak to add, for example, noise to
the video. Actually there exists a plugin that achieves the same, but this was
just to have a placeholder in case I need to add some custom filters. In this
case it wasn't that difficult as in the Wireshark's plugins case, but still the
information I could find googling was not enough and outdated in some cases.
However I also found this quite interesting and useful for some quick proof of
concepts as you have all the decoding/encoding power of FFMPEG but you can
easily implement a *man in the middle* attack!

  * On the third hand...yes, whatever! I've also been having a look to Twitter's
    Bootstrap to use it as a web interface to control some of our systems. I
friend of mine who has been a web developer for Hyves (the Dutch Facebook)
recommended this to me as an accessible set of web widgets. Basically I didn't
want to care too much about the look and feel. While learning it I found quite
interesting the fact that it is done merely with CSS and JavaScript, which
allows for an embedded system to have quite a lightweight web server as there is
no need for any server side support, like PHP. I immediately felt in love with
Bootstrap because of this but, as always, I had problems to set up the first
mockup of my project. Luckily I found a beta project called
[Divshot](http://www.divshot.com/) that offers an online WYSIWYG tool to compose
websites using Bootstrap. As opposed to [Jetstrap](http://www.jetstrap.com/),
Divshot is still in beta stage and you don't have to pay for it (although
Jetstrap allows you to create one website for free, I liked Divshot more). So I
created my stepping stone through Divshot, got the result and then customized
it manually to my needs. The result is actually pretty cool and I'm really happy
with it. Let's Bootstrap!!

One last thing I've learned on this road trip is about WebSockets. I was
completely convinced that WebSockets were just plain TCP sockets brought to the
browser, but they are actually quite different, and although based on TCP
sockets (of course!) they add an extra layer that you must comply with. So in
the end to implement a server that provides data to a web interface, you need to
actually implement a WebSocket server, which is something I don't like.

Anyway, it's been a cool trip and now I continue designing my web interface and
trying to add some cool animations to it. Later on I'll ask for the advise of my
Hyves friend as he's an expert in usability and design, to let him criticize my
first web development attempt!

Soon, I hope, more on my OpenGL development adventure!
