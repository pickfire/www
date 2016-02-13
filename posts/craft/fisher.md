Raster Graphic -> Vector Graphic (by hand)
==========================================

The advantages of [Vector Graphic][v] over [Raster Graphic][r]:
  - Viewable at any zoom level
  - Smaller file size

I have been given a task to change the fisherman's logo (15k) into a [high
resolution svg](https://github.com/fisherman/fisherman/issues/76). I am using
the [inkscape editor](https://inkscape.org/) to do this task.

[r]: https://en.wikipedia.org/wiki/Raster_graphics
[v]: https://en.wikipedia.org/wiki/Vector_graphics
[f]: http://dl.pickfire.wha.la/usr/img/ofish.svg

Getting started
---------------
[![inkscape][i1]][i1]

1. **Import** (`Ctrl+I`) the background.
2. Toggle the **Layers** with `Shift+Ctrl+L`.
3. *Create* 2 **new layers** (one for the **word** and one for **hook**).
   - **Lock** the *background layer* just to make sure it's safe.
   - ***Tips:*** Lower the opacity on non-background to copy easier.
   - ***Tips:*** Enter `4` to zoom to the width of the drawing.

[i1]: img/ink1.png

Drawing the words
-----------------
[![inkscape][i2]][i2]

1. **Switch** to the *second* layer (`Ctrl+PageUp`).
2. Use `Shift+F6` to **draw** the *curves and straight lines*.
3. **Select** those words that have *inner part* (eg. `R`).
4. Use **Subtract** with `Ctrl+-` to remove those *inner parts*.
5. **Select** those words that have *overlapped part* (eg. `RM`).
6. Use **Union** with `Ctrl++` for parts that are *overlapped*.

### After drawing
1. **select all** of it.
2. Toggle the **Fill and Stroke** with `Shift+Ctrl+L`.
3. Use a *flat color* for the **fill** and disable the **stroke color**.

[i2]: img/ink2.png

Drawing the anchor
------------------
[![inkscape][i3]][i3]

1. **Switch** to the *third* layer (`Ctrl+PageUp`).
2. **Hide** (the eye button) the *second* layer to focus on the anchor.
3. **Draw** the empty space (anchor) in the words and fill the gaps.
   - ***Tips:*** Use a random color to draw the anchor to draw easier.
4. **Select** the anchor and toggle the **Fill and Stroke**.
5. Max out the options in the **RGB** section to make it white.

[i3]: img/ink3.png

The final farewell
------------------
[![inkscape][i4]][i4]

1. In **Document Properties** (`Shift+Ctrl+D`), set custom size and resize page
   to drawing.
2. **Save** (`Ctrl+S`) the file as a backup copy.
3. **Delete** the background layer and **Unhide** the other layers.
4. **Save As** (`Shift+Ctrl+S`) the file as an *optimized svg*.
   - **Remove XML indentation** and tons of stuff to keep it **minimal**.
5. **_TADA_ Work done!**

[i4]: http://dl.pickfire.wha.la/usr/img/fisherman.svg
