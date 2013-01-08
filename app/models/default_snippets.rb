module DefaultSnippets

  Polygon = '''command polygon [ sides size ] [
        repeat sides [
            forward size right divide [ 360 sides ]
        ]
    ]'''

  PythagorasTree = '''command pythagoras-tree [ size ] [
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
    ]'''

end
