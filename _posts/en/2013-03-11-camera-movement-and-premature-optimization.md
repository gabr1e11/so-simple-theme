--- 
title: Camera movement and premature optimization
author: rcano
layout: post
image:
  feature: Unreal-Engine_logo.jpg
categories:
  - Programming
---

While writing the first bits and bytes of my 'I-want-to-learn-OpenGL' engine I
stamped myself against the camera implementation. As a first approach I was
trying to implement one of those fancy FPS walking cameras.

I'm currently using the [GLM Library](http://glm.g-truc.net/), which tries to add back all the functionality
present in previous versions of OpenGL and GLUT to the new GLSL pipeline. Things
like rotations, translation, perspective and orthogonal projections are
available in the library.

When thinking about how to implement the camera movement, my first approach was
to use a look_at vector that would serve both as the direction of the camera (so
the view vector) and the direction of the movement when using the forward key.

Also the control through the mouse would use the typical YAW, PITCH and ROLL
concepts.

By this time I was presented to the Gimbal Lock concept that I will try to
tackle, both in code and blog, in the future.

But then I ran into a problem. If I wanted the camera to move realistically,
every time the forward key was pressed I should move the camera in the direction
of the look\_at vector. This meant updating the camera accordingly applying the
Yaw, Pitch, Roll rotation to the look\_at vector before using that vector to
move forward. So I did so.

The result: I lost almost a 30% of performance just by calculating the rotation
every time!!

I was not surprised by the lost of performance, but I couldn't believe
professional applications were spending a 30% of the time in calculating camera
rotations.

Finally I decided to cheat a little bit on the user.

As we are going to update the screen around 60 times per second, and the user
cannot see the intermediate movements (only the final one), I don't update
the look\_at vector until the time for the rendering is due. Then I apply the
rotation to the look\_at vector and I apply the movement according to that
vector.

This is not exactly accurate, but it works. To understand why it is not accurate
think about the following scenario:

  * The user faces the north
  * Then turns the camera 90 degrees left, to the west, and moves 10 units
  * Then quickly turns the camera 180 degrees to the right, facing east, and
    moves 10 units
  * Finally turns 90 degrees left, facing north again

Net result: no movement at all when the frame is rendered.

Result with my fake implementation: 20 units of movement towards the
north!

However is hardly noticeable, and it saves a lot of time. Maybe when I can
use Quaternions it could become more realistic...who knows!
