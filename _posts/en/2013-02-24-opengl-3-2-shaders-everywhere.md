---
id: 26
title: 'OpenGL 3.2: shaders everywhere!'
author: rcano
layout: post
image:
  feature: OpenGL_logo.jpg
categories:
  - Programming
---

Now that I'm getting involved into OpenGL 3.2 I realize how different it is from OpenGL 1.2 (the last one I learned long time ago). No more glBegin/glEnd blocks and only VAOs (vertex array objects) and  VBOs (vertex buffer objects), shaders and basically server side structures and processing.

Today while trying out some demos and writing some example code to understand better how all this new structures are working together I found out that I really need a deep understanding of GLSL (GL Shading Language) to be able to do some cool things.

After managing to create a color cube using VBOs, I fancy trying to outline the 3D geometry as I thought it could look cool. However, I struggled doing it as the only feasible way, as far as I could understand, is by using shaders. As currently my knowledge of shaders is rather low, I couldn't find a way to create the outline.

Anyhow I feel it is a quite powerful tool to generate really nice effects, but I;ll have to wait until I'm confident with the basics of OpenGL 3.2 to be prepared to tackle GLSL and understand its deepness.

Another thing I found about OpenGL3.2 is that it eliminated the fixed pipeline by which OpenGL pre 3.1 renderered the primitives (applying transformations, rotation, scaling, MVP matrices, etc,,,) and now it is all done through shaders. So the next demos I intended to do with VBOs and VAOs is not working just because I need a simple shader to be incorporated to the rendering of the scene!

Next step, more VBO, camera and lighting. Set, ready, action!
