# lectronimo

<img src="https://raw.github.com/glucero/lectronimo/master/resources/lectronimo_main.png" alt="lectronimo" height="200" width="320" >

### building your own lectronimo

  lectronimo has been written with RubyMotion (booya), so a valid RubyMotion license is required. if you would like to run lectronimo on something other than the iOS simulator, a valid iOS developer certificate is also required

    git clone git@github.com:glucero/lectronimo.git
    cd lectronimo
    bundle install
    rake -T

### detailed usage instructions are built into the compiled iOS app

### available commands

    (aliases for these commands are listed in the app's help files)

    forward reset          divide     arccosine  make
    back    clear          absolute   arctangent repeat
    right   penup          power      logarithm  command
    left    pendown        modulo     hypotenuse same
    goto    pensize        squareroot pi         different
    xy      pencolor       cuberoot   phi        more
    heading randompencolor sine       euler      if
    show    add            cosine     degree     ifelse
    hide    subtract       tangent    radian
    home    multiply       arcsine    random

### lectronimo's programming language is based on LOGO 

  all commands are in prefix notation

    forward 100
    add [ 5 3 ]
    pencolor blue
    right multiply [ 10 90 ]

  multiple expressions are allowed on the same line

    forward 100 right 90 forward 100 right 90 forward 100 right 90 forward 100 right 90

### a few advanced examples

creating a polygon command:

    command polygon [ sides size ] [
      repeat sides [
        forward size right divide [ 360 sides ]
      ]
    ]

using the new polygon command:

![triangle](https://raw.github.com/glucero/lectronimo/master/assets/triangle.png)
![square](https://raw.github.com/glucero/lectronimo/master/assets/square.png)
![circle](https://raw.github.com/glucero/lectronimo/master/assets/circle.png)
![spyrograph](https://raw.github.com/glucero/lectronimo/master/assets/spyrograph.png)
![rainbow-spyrograph](https://raw.github.com/glucero/lectronimo/master/assets/rainbow-spyrograph.png)

creating a pythagoras tree:

    command pythagoras-tree [ size ] [
        repeat 4 [ forward size left 90 ]
        forward size left 90 forward size right 90
        right divide [ arcsine divide [ 3 5 ] degree ]
        forward multiply [ 3 divide [ size 5 ] ] right 90
        forward multiply [ 4 divide [ size 5 ] ]
        left divide [ arcsine divide [ 3 5 ] degree ] back size left 90
        right divide [ arcsine divide [ 3 5 ] degree ]
        forward multiply [ 3 divide [ size 5 ] ] left 90
        ifelse [ more [ size 3 ] ]
            [ pythagoras-tree multiply [ 3 divide [ size 5 ] ] ]
            [ repeat 4 [ forward multiply [ 3 divide [ size 5 ] ] left 90 ] ]
        back multiply [ 4 divide [ size 5 ] ] right 90
        ifelse [ more [ size 3 ] ]
            [ pythagoras-tree multiply [ 4 divide [ size 5 ] ] ]
            [ repeat 4 [ forward multiply [ 4 divide [ size 5 ] ] left 90 ] ]
        left divide [ arcsine divide [ 3 5 ] degree ] back size
    ]

using the new pythagoras-tree command:

![pythagoras-tree](https://raw.github.com/glucero/lectronimo/master/assets/pythagoras-tree.png)

***

### Copyright (C) 2013 Gino Lucero

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a>

