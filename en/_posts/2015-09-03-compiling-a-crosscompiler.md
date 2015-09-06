---
title: How to compile a cross-compiler
layout: post
image:
  feature: gcc-logo.png
tags:
  - Programming
---

# Why on earth would you do that?[^1]

Good question! TLDR: I'm bored.

Recently I was raking through the tons of data I've stored in my main backup drive and enjoying
the good ol' times, when I stumbled upon one project I had parked away long time ago: the Dreamcast
emulator! I will talk in detail about this project in a future post. For now it suffices to say that
I've revived the project and I'm currently working on it in my spare time. As a first approach to the
emulator I decided that it would be a feasible and achievable sub-project to just write the main
processor emulator.

To do so not only I need to write the emulating code itself but, most important, I need exectuables
to test the emulator with.

Hence the necessity to have a SH cross-compiler to compile test code and test the emulator with it.

> But why don't you just download the cross-compiler??

Good question! TLDR: I work on Mac, and couldn't find any.

Well, yeah, that's it. No longer version of the answer[^2]

# How en earth do you do that?[^3]

How do you compile a compiler? How do you compile a cross-compiler? How do you manage to get on your blog's visitors nerves?
For the first two keep on reading. For the third....well, keep on reading.....

A long long time and space ago in a galaxy far far away[^4] there were machines that could execute binary code: we called them
computers. And the binary code was written manually by yet another kind of machine: the humans. To do so the humans used
a language called assembly, a collection of mnemonics and parameters that translated straight into binary. Life was good and simple,
except that humans spent humongous amounts of time to write this code, until they realized that they could use the computers to do the
work for them: the first compiler was born! [^5]

These very first compilers ever written were done using assembly. Later on in history the programmers realized that once
they had the first compiler for a certain language (let's say C), they could rewrite the compiler in the same language
the compiler was aimed to compile from. This lead to self-hosted compilers!! There have been plenty of them and one of
the most usual ones is GCC, the GNU C compiler, which was written originally in C, and later in C++.

The GCC collection of compilers is the biggest and greatest ever thanks to its layered architecture. This allows
GCC to be compiled using GCC to generate any compiler for almost any known CPU architecture.

And that is what the next setion is about: how to compile GCC for the SH architecture.

# So, please, how do you compile the GCC cross-compiler for SH?[^6]

Well, here it goes. First of all, disclaimer: I've tried this method in both Mac OS X Yosemite 10.10.5 and Ubuntu 14.04LTS
and steps or instructions may vary for your own OS flavour.

## Install the normal version of GCC for your machine

The first thing we need is the normal GCC compiler for C and C++. The recommendation is to get at least the same major and
minor version of the compiler we'll be compiling. This means that if you want to compile the 4.8.2 version of GCC you must
install in your machine any of the 4.8.x versions of the normal compiler.

In Ubuntu this is a piece of cake and you can do something similar to:

    sudo apt-get install gcc-4.8 g++-4.8

For Mac OS X the best option is to install Homebrew and install the compiler from there. For instructions on how
to install Homebrew see [here][1]. Once installed execute the following commands in a terminal:

    sudo brew tap homebrew/versions
    sudo brew install gcc48

This will install the gcc and g++ compiler into /usr/local/bin.

## Prepare the filesystem and grab the required sources

To compile GCC we will need to download 3 different source packages: GCC, binutils and newlib. Instead of newlib you
can use glibc but this guide uses newlib. Also to grab the sources I use wget. If you don't have wget you can install
it with:

    sudo brew install wget

Or simply copy paste the URL to a browser.

First create the directory structure that will host the new compiled tools. The structure I use is not mandatory and
you can choose any of your own as far as you keep it consistent.

    sudo mkdir -p /opt/cross/src/
    sudo mkdir -p /opt/cross/gcc-sh/

Adjust the permission of the newly created directories as needed so you can enter, write and read them. Now switch to the
src directory and download the packages we need:

    cd /opt/cross/src/
    wget ftp://sourceware.org/pub/binutils/releases/binutils-2.24.tar.gz
    wget http://www.netgull.com/gcc/releases/gcc-4.8.2/gcc-4.8.2.tar.gz
    wget ftp://sourceware.org/pub/newlib/newlib-2.1.0.tar.gz

Expand the packages:

    tar xzvf binutils-2.24.tar.gz
    tar xzvf gcc-4.8.2.tar.gz
    tar xzvf newlib-2.1.0.tar.gz

Create the directories where the compilation scripts will be created:

    mkdir binutils-build
    mkdir gcc-build
    mkdir newlib-build

And last but not least download all required GCC pre-requisites:

    cd /opt/cross/src/gcc-4.8.2/
    ./contrib/download_prerequisites

## Export all required variables

You need to export some variables for the compilation of the packages to work:

    export CC=/usr/local/bin/gcc-4.8
    export CXX=/usr/local/bin/g++-4.8
    export CPP=/usr/local/bin/cpp-4.8
    export LD=/usr/local/bin/gcc-4.8
    export PREFIX=/opt/cross/gcc-sh/
    export PATH=$PATH:$PREFIX/bin

## Generate the compilation scripts and compile!

We will use make to compile the packages. A common option for make is -j which tells make how many parallel
processes to spawn in order to compile the code. Adjust that number to your machine's number of processors.
If your machine has more than one virtual/physical processor I suggest to use the maximum number of processors
minus 1, so you can continue doing other things while the compilation proceeds. In the examples below I will
be using -j8 as the option to make. Please change that accordingly.

To determine the number of processors in Ubuntu, check the proc filesystem:

    cat /proc/cpuinfo | grep processor | wc -l

In Mac you can use sysctl:

    sysctl -n hw.ncpu

Now, the three packages we've downloaded make use of the configure tool to generate the compilation scripts
for the machine where the package will be compiled. To do this we switch to the corresponding build
directory and generate the scripts there: 

    cd /opt/cross/src/binutils-build
    ../binutils-2.24/configure --target=sh-elf --prefix=$PREFIX --disable-nls --disable-werror
    make -j8 all install

Next step is to compile a bootstrap version of GCC supporting only C language. A bootstrap version is a GCC with the
minimum functionality we need to compile other parts of the compiler or, like in our case, to compile newlib. We will
use this stripped-off version to cross-compile newlib and then compile a full GCC against it.

    cd /opt/cross/src/gcc-build
    ../gcc-4.8.2/configure --target=sh-elf --prefix=$PREFIX --with-newlib --without-headers --enable-languages=c --disable-nls --disable-libssp
    make -j8 all install

It is important to disable libssp for GCC as this library is quite big and will cause GCC compilation to break for SH
alleging some size_t symbol being missed.

OK, now we can proceed to cross-compile newlib with the bootstrapped compiler:

    cd /opt/cross/src/newlib-build
    ../newlib-2.1.0/configure --target=sh-elf --prefix=$PREFIX --disable-nls --disable-libssp --disable-werror
    make -j8 all install

And finally compile the full GCC with C and C++ support:

    cd /opt/cross/src/gcc-build && rm -rf *
    ../gcc-4.8.2/configure --target=sh-elf --prefix=$PREFIX --with-newlib --without-headers --enable-languages=c,c++ --disable-nls --disable-libssp
    make -j8 all install

Voilá! We have a full GCC cross-compiler

## Why so serious?

Ops! It's true, this tutorial has ended up being a real true professional and serious tutorial!! Hope you've enjoyed it anyway and
that it may be of help to you, legion of crazy cross-compiler compiling bashtards!! [^7]

Next time I will talk about the Dreamcast emulation, interpreters, dynarec and static binary translation. Can't wait for it!! [^8]

------------------

 [1]: http://brew.sh/

 [^1]: Watch me digress across this section. For the real stuff, go to next section
 [^2]: For a longer version of the answer, read it twice.
 [^3]: Watch me introduct you to a brief history of the compiler while I continue digressing. For the real real stuff, go to next section
 [^4]: Yeah, well, our own galaxy was far far away long time ago, right?
 [^5]: Strictly speaking the tool that translated assembly to machine code was called assembler, not compiler
 [^6]: For real, Jo!
 [^7]: See what I did there! :D
 [^8]: For real, Jo?









