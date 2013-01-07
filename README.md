# lectronimo

  an educational iOS app that teaches the basics of programming by drawing shapes, spirals and other designs

<img src="https://raw.github.com/glucero/lectronimo/master/resources/lectronimo_main.png" alt="lectronimo" height="200" width="320" >

### building your own lectronimo

  lectronimo has been written with RubyMotion (booya), so a valid RubyMotion license is required. if you would like to run lectronimo on something other than the iOS simulator, a valid iOS developer certificate is also required

    git clone git@github.com:glucero/lectronimo.git
    cd lectronimo
    bundle install
    rake -T

### support this project

  lectronimo will be available on the App Store soon!


### detailed usage instructions are built into the compiled iOS app

### available commands

    (aliases for these commands are listed in the app's help files)

    forward reset    absolute   arctangent repeat
    back    clear    power      logarithm  command
    right   penup    modulo     hypotenuse same
    left    pendown  squareroot pi         different
    goto    pensize  cuberoot   phi        more
    xy      pencolor sine       euler      if
    heading add      cosine     degree     ifelse
    show    subtract tangent    radian     randompencolor
    hide    multiply arcsine    random
    home    divide   arccosine  make

### lectronimo's programming language is based on LOGO (a LISP-like language without the parentheses):

  all commands are in prefix notation

    forward 100
    add [ 5 3 ]
    pencolor blue

  multiple expressions are allowed on the same line

    forward 100 right 90 forward 100 right 90 forward 100 right 90 forward 100 right 90

### a few advanced examples

creating your own polygon command:

    command polygon [ sides size ] [
      repeat sides [
        forward size right divide [ 360 sides ]
      ]
    ]

using the newly created polygon command:

![triangle](https://raw.github.com/glucero/lectronimo/master/assets/triangle.png)
![square](https://raw.github.com/glucero/lectronimo/master/assets/square.png)
![circle](https://raw.github.com/glucero/lectronimo/master/assets/circle.png)
![spyrograph](https://raw.github.com/glucero/lectronimo/master/assets/spyrograph.png)
![rainbow-spyrograph](https://raw.github.com/glucero/lectronimo/master/assets/rainbow-spyrograph.png)

creating a pythagoras tree:

    make angle divide [ arcsine divide [ 3 5 ] degree ]

    command square [ size ] [
        repeat 4 [ forward size left 90 ]
    ]

    command subdivide [ ratio size ] [
        multiply [ ratio divide [ size 5 ] ]
    ]

    command pythagorean-triangle [ size ] [
        right angle forward subdivide 3 size
        right 90 forward subdivide 4 size
        left angle back size left 90
    ]

    command tree-or-square [ ratio size ] [
        ifelse [ more [ size 3 ] ]
            [ pythagoras-tree subdivide ratio size ]
            [ square subdivide ratio size ]
    ]

    command starting-position [ size ] [
        if [ same [ size 100 ] ]
            [ penup left 90 forward 150 right 90 back 150 pendown ]
    ]

    command pythagoras-tree [ size ] [
        starting-position size
        square size
        forward size left 90 forward size right 90
        pythagorean-triangle size
        right angle forward subdivide 3 size left 90
        tree-or-square 3 size
        back subdivide 4 size right 90
        tree-or-square 4 size
        left angle back size
    ]


using the new pythagoras-tree command:

    pythagoras-tree 100

![pythagoras-tree](https://raw.github.com/glucero/lectronimo/master/assets/pythagoras-tree.png)

***

### Copyright (C) 2013 Gino Lucero

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.

