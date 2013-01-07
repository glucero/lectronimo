module DefaultSnippets

  Polygon = '''command polygon [ sides size ] [
        repeat sides [
            forward size right divide [ 360 sides ]
        ]
    ]'''

  PythagorasTree = '''make angle divide [ arcsine divide [ 3 5 ] degree ]

    command square [ size ] [
        repeat 4 [
            forward size left 90
        ]
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
    ]'''

end
