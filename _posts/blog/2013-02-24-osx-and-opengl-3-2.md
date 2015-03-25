---
id: 27
title: OSX and OpenGL 3.2
author: rcano
layout: post
guid: http://www.robertocano.es/?p=27
permalink: /2013/02/osx-and-opengl-3-2/
blogger_blog:
  - www.gabriell.es
blogger_author:
  - Roberto Cano
blogger_permalink:
  - /2013/02/osx-and-opengl-32.html
blogger_internal:
  - /feeds/1837616560811891684/posts/default/2705091361136000611
categories:
  - Programming
---
<div style="clear: both; text-align: center;">
</div>

Recently I&#8217;ve bought the famous Red Book for OpenGL. This is the 7th edition (so OpenGL 3.3). I bought this one because OSX Mountain Lion only supports OpenGL 3.2 (by now) and I didn&#8217;t want to experiment the frustration of trying to setup an example that finally I couldn&#8217;t run.

Anyway the experience is starting to be quite a nightmare. It turns out that the resources available on the internet to setup an OpenGL 3.2 example under OSX Lion using C++ are scarce. Most of them focus on bringing OpenGL 3.2 rendering context using Cocoa and ObjectiveC. While good enough for a bit of testing, it is not what I wanted to start playing around with OpenGL. I needed either C or C++, and even though I saw some examples of how to setup an ObjectiveC/C++ binding, I didn&#8217;t want to spend time on it.

Finally it turned out that the solution was named <a href="http://www.glfw.org/" target="_blank">GLFW</a>. GLFW is the replacement of GLUT (the GL Utility Toolkit) that was famous a long time ago. Now GLUT is still available but it looks like it doesn&#8217;t support window hints for OpenGL context creation, which is what is needed to create OpenGL 3.2 contexts.

I found really nice examples at [www.opengl-tutorials.org][1]. They setup the OpenGL context using GLFW and GLEW. <a href="http://glew.sourceforge.net/" target="_blank">GLEW</a> is the GL Extension Wrangler, a helper library to determine which OpenGL extensions are available in run-time. With this two libraries OpenGL 3.2 context creation is a piece of cake. First include GLEW and GLFW. You must do this in that order as GLEW will complain if *gl.h* is already included:

<pre>// Include GLEW
#include &lt;GL/glew.h&gt;

// Include GLFW
#include &lt;GL/glfw.h&gt;</pre>

Now it&#8217;s time to initialise GLFW and set the hints for the window so the created OpenGL context is 3.2:

<pre>glfwInit()
glfwOpenWindowHint(GLFW_OPENGL_VERSION_MAJOR, 3);
glfwOpenWindowHint(GLFW_OPENGL_VERSION_MINOR, 2);
glfwOpenWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);</pre>

After this a GLFW window can be opened with a OpenGL 3.2 context associated to it:

<pre>glfwOpenWindow( 1024, 768, 0,0,0,0, 32,0, GLFW_WINDOW );</pre>

The last step is to initialise GLEW to be able to use the core profile of OpenGL 3.2. To do this, the experimental mode of GLEW must be activated:

<pre>glewExperimental = true;
glewInit();</pre>

There we go. With this an OpenGL 3.2 context is created and we are ready to issue OpenGL commands. Remember that OpenGL 3.2 is quite different to OpenGL 2.1, like for example no more glBegin()/glEnd commands are used to render geometry. Instead use VBO (vertex buffer objects) to do it so.

The last thing to remember is that you must link against GLFW and GLEW, as well as against OpenGL. In Mac OS X this is  achieved by adding the following flags while linking:

<pre>-lglfw -lglew -framework OpenGL</pre>

Happy OpenGL coding!!

 [1]: http://www.opengl-tutorials.org/