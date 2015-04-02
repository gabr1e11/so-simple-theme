---
title: OSX and OpenGL 3.2
author: rcano
layout: post
image:
  feature: OpenGL_logo.jpg
categories:
  - Programming
---

Recently I've bought the famous Red Book for OpenGL. This is the 7th
edition (so OpenGL 3.3). I bought this one because OSX Mountain Lion only
supports OpenGL 3.2 (by now) and I didn't want to experiment the
frustration of trying to setup an example that finally I couldn't run.

Anyway the experience is starting to be quite a nightmare. It turns out that
the resources available on the internet to setup an OpenGL 3.2 example under
OSX Lion using C++ are scarce. Most of them focus on bringing OpenGL 3.2
rendering context using Cocoa and ObjectiveC. While good enough for a bit of
testing, it is not what I wanted to start playing around with OpenGL. I needed
either C or C++, and even though I saw some examples of how to setup an
ObjectiveC/C++ binding, I didn't want to spend time on it.

Finally it turned out that the solution was named [GLFW][1]
GLFW is the replacement
of GLUT (the GL Utility Toolkit) that was famous a long time ago. Now GLUT is
still available but it looks like it doesn't support window hints for
OpenGL context creation, which is what is needed to create OpenGL 3.2 contexts.

I found really nice examples at [www.opengl-tutorials.org][2]. They setup the
OpenGL context using GLFW and GLEW. [GLEW][3]
is the GL Extension Wrangler, a helper library to
determine which OpenGL extensions are available in run-time. With this two
libraries OpenGL 3.2 context creation is a piece of cake. First include GLEW
and GLFW. You must do this in that order as GLEW will complain if *gl.h* is
already included:

{% highlight c %}
// Include GLEW
#include <GL/glew.h>
// Include GLFW
#include <GL/glfw.h>
{% endhighlight %}

Now it's time to initialise GLFW and set the hints for the window so the
created OpenGL context is 3.2:

{% highlight c %}
glfwInit();
glfwOpenWindowHint(GLFW_OPENGL_VERSION_MAJOR, 3);
glfwOpenWindowHint(GLFW_OPENGL_VERSION_MINOR, 2);
glfwOpenWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
{% endhighlight %}

After this a GLFW window can be opened with a OpenGL 3.2 context associated to
it:

{% highlight c %}
glfwOpenWindow( 1024, 768, 0,0,0,0, 32,0, GLFW_WINDOW );
{% endhighlight %}

The last step is to initialise GLEW to be able to use the core profile of
OpenGL 3.2. To do this, the experimental mode of GLEW must be activated:

{% highlight c %}
glewExperimental = true;
glewInit();
{% endhighlight %}

There we go. With this an OpenGL 3.2 context is created and we are ready to
issue OpenGL commands. Remember that OpenGL 3.2 is quite different to OpenGL
2.1, like for example no more glBegin()/glEnd commands are used to render
geometry. Instead use VBO (vertex buffer objects) to do it so.

The last thing to remember is that you must link against GLFW and GLEW, as well
as against OpenGL. In Mac OS X this is  achieved by adding the following flags
while linking:

{% highlight bash %}
-lglfw -lglew -framework OpenGL
{% endhighlight %}

Happy OpenGL coding!!

 [1]: http://www.glfw.org/
 [2]: http://www.opengl-tutorials.org/
 [3]: http://glew.sourceforge.net/"

