Multi-pointer in DWM
====================

Multi-pointer can be an alternative to multi-seat. Compared to multi-seat,
multi-pointer is easier to setup (because no multi-seat experience), allows
hardware acceleration and at least one monitor is required. Bad news? Both
shared the same xorg server, most things are shared.

As of now, no window manager with active development support multi-pointers
with multiple active window. Dwm does not support multi-pointer but here's a
crappy version in which the other users can only control one application
through keyboard since there is only one active window at a time.

Configuring inputs
------------------

One way to configure input devices is via the `xinput` tool. Without any
arguments given, it should list all the input devices in short format.

    xinput

It will print all the master device (cursors on screen) and the slave device
(physical device). Master device comes in pair, which is pointer and keyboard.

Adding master device
--------------------

To create another pointer for a new user. First, we add a master device.

    xinput create-master Name

Another pointer should appear in the center of the screen by now.

Assigning slave device
----------------------

We will then require to assign a slave device to the master device. The *id* of
the **master** and **slave** device can be found by using `xinput`.

    xinput reattach <slave> <master>

By the end of this, both pointer can move simultaneously but keyboard cannot
type in different application simultaneously, this is normal for window manager
without multi-pointer support.

Point master device to window
-----------------------------

Time to point the master device to the respective window, do this for both
pointer and keyboard master device (not sure if specifying one works).

The **window** is the PID of window which can be checked with either `xprop`
(useless sometimes) or `xdotool selectwindow`.

    xinput set-cp <window> <master>

If the setup is successful, the other keyboard should be able to input only in
the window. In which multiple user can play different games at the same time.

Cleaning up
-----------

Remove all the master device that was created.

    xinput remove-master <master>

And `reattach` the pointer or keyboard back to the main master device.

Ideas
-----

- The other could have used Xephyr or Xnest to have his own session instead.

See also
--------

- <https://ao2.it/en/blog/2010/01/19/poor-mans-multi-touch-using-multiple-mice-xorg>
- <https://www.x.org/wiki/Development/Documentation/MPX/>

