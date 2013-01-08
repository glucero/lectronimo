module Vocabulary

  Commands = [

    { :name        => :forward,
      :alias       => :fd,
      :arg         => 1,
      :examples    => ['FORWARD X', 'FD X'],
      :description => "Move forward X units from current location." },

    { :name        => :back,
      :alias       => :bk,
      :arg         => 1,
      :examples    => ['BACK X', 'BK X'],
      :description => "Move backwards X units from current location." },

    { :name        => :right,
      :alias       => :rt,
      :arg         => 1,
      :examples    => ['RIGHT X', 'RT X'],
      :description => "Turn right X degrees from current heading." },

    { :name        => :left,
      :alias       => :lt,
      :arg         => 1,
      :examples    => ['LEFT X', 'LT X'],
      :description => "Turn left X degrees from current heading." },

    { :name        => :goto,
      :alias       => :go,
      :arg         => 1,
      :examples    => ['GOTO [ X Y ]', 'GO [ X Y ]'],
      :description => 'Move to coordinate X, Y.' },

    { :name        => :xy,
      :arg         => 1,
      :examples    => ['XY [ X Y ]' ],
      :description => 'Move to coordinate X, Y without drawing a line.' },

    { :name        => :heading,
      :arg         => 1,
      :examples    => ['HEADING X'],
      :description => "Change heading to X degrees." },

    { :name        => :face,
      :arg         => 1,
      :examples    => ['FACE [ X Y ]'],
      :description => "Change heading to face coordinate X, Y." },

    { :name        => :show,
      :arg         => 0,
      :examples    => ["SHOW"],
      :description => "Show Lectronimo's icon on the Canvas." },

    { :name        => :hide,
      :arg         => 0,
      :examples    => ['HIDE'],
      :description => "Hide Lectronimo's icon from the Canvas." },

    { :name        => :home,
      :arg         => 0,
      :examples    => ['HOME'],
      :description => 'Move to the center of the Canvas.' },

    { :name        => :reset,
      :arg         => 0,
      :examples    => ['RESET'],
      :description => 'Move to the center of the Canvas and erase all drawn paths.' },

    { :name        => :clear,
      :arg         => 0,
      :examples    => ['CLEAR'],
      :description => 'Erase all drawn paths from the Canvas.' },

    { :name        => :penup,
      :alias       => :pu,
      :arg         => 0,
      :examples    => ['PENUP'],
      :description => "Don't draw a path while moving." },

    { :name        => :pendown,
      :alias       => :pd,
      :arg         => 0,
      :examples    => ['PENDOWN'],
      :description => "Draw a path while moving." },

    { :name        => :pensize,
      :alias       => :ps,
      :arg         => 1,
      :examples    => ['PENSIZE X', 'PS X'],
      :description => "Draw a path X pixels wide while moving." },

    { :name        => :pencolor,
      :alias       => :pc,
      :arg         => 1,
      :examples    => ['PENCOLOR X', 'PC X'],
      :description => "Use an X colored path when drawing." },

    { :name        => :randompencolor,
      :alias       => :rpc,
      :arg         => 0,
      :examples    => ['RANDOMPENCOLOR', 'RPC'],
      :description => "Use an random colored path when drawing." },

    { :name        => :add,
      :arg         => 1,
      :examples    => ['ADD [ A B C ]'],
      :description => "Return A plus B plus C." },

    { :name        => :subtract,
      :alias       => :sub,
      :arg         => 1,
      :examples    => ['SUBTRACT [ A B C ]', 'SUB [ A B C ]'],
      :description => "Return A minus B minus C." },

    { :name        => :multiply,
      :alias       => :mul,
      :arg         => 1,
      :examples    => ['MULTIPLY [ A B C ]', 'MUL [ A B C ]'],
      :description => "Return A times B times C." },

    { :name        => :divide,
      :alias       => :div,
      :arg         => 1,
      :examples    => ['DIVIDE [ A B C ]', 'DIV [ A B C ]'],
      :description => "Return A divided by B, divided by C." },

    { :name        => :absolute,
      :alias       => :abs,
      :arg         => 1,
      :examples    => ['ABSOLUTE X', 'ABS X'],
      :description => "Return the absolute value of X" },

    { :name        => :power,
      :alias       => :pow,
      :arg         => 1,
      :examples    => ['POWER [ A B ]', 'POW [ A B ]'],
      :description => "Return A the Bth power." },

    { :name        => :modulo,
      :alias       => :mod,
      :arg         => 1,
      :examples    => ['MODULO [ A B ]', 'MOD [ A B ]'],
      :description => "Return modulo after division of A by B." },

    { :name        => :squareroot,
      :alias       => :sqrt,
      :arg         => 1,
      :examples    => ['SQUAREROOT X', 'SQRT X'],
      :description => "Return the square root of X." },

    { :name        => :cuberoot,
      :alias       => :cbrt,
      :arg         => 1,
      :examples    => ['CUBEROOT X', 'CBRT X'],
      :description => "Return the cube root of X." },

    { :name        => :sine,
      :alias       => :sin,
      :arg         => 1,
      :examples    => ['SINE X', 'SIN X'],
      :description => "Return the sine of X." },

    { :name        => :cosine,
      :alias       => :cos,
      :arg         => 1,
      :examples    => ['COSINE X', 'COS X'],
      :description => "Return the cosine of X." },

    { :name        => :tangent,
      :alias       => :tan,
      :arg         => 1,
      :examples    => ['TANGENT X', 'TAN X'],
      :description => "Return the tangent of X." },

    { :name        => :arcsine,
      :alias       => :asin,
      :arg         => 1,
      :examples    => ['ARCSINE X', 'ASIN X'],
      :description => "Return the arc sine of X." },

    { :name        => :arccosine,
      :alias       => :acos,
      :arg         => 1,
      :examples    => ['ARCCOSINE X', 'ACOS X'],
      :description => "Return the arc cosine of X." },

    { :name        => :arctangent,
      :alias       => :atan,
      :arg         => 1,
      :examples    => ['ARCTANGENT X', 'ATAN X'],
      :description => "Return the arc tangent of X." },

    { :name        => :logarithm,
      :alias       => :log,
      :arg         => 1,
      :examples    => ['LOGARITHM X', 'LOG X'],
      :description => "Return the natural logarithm of X." },

    { :name        => :hypotenuse,
      :alias       => :hypot,
      :arg         => 1,
      :examples    => ['HYPOTENUSE [ A B ]', 'HYPOT [ A B ]'],
      :description => "Returns the square root of A times A added to B times B." },

    { :name        => :pi,
      :arg         => 0,
      :examples    => ['PI'],
      :description => "Returns the ratio of a circle's circumference to its diameter." },

    { :name        => :phi,
      :arg         => 0,
      :examples    => ['PHI'],
      :description => "Returns 1 plus the square root of 5 divided by 2." },

    { :name        => :euler,
      :arg         => 0,
      :examples    => ['EULER'],
      :description => "Returns the base of the natural logarithm." },

    { :name        => :degree,
      :alias       => :deg,
      :arg         => 0,
      :examples    => ['DEGREE', 'DEG'],
      :description => "Returns PI divided by 180." },

    { :name        => :radian,
      :alias       => :rad,
      :arg         => 0,
      :examples    => ['RADIAN', 'RAD'],
      :description => "Returns PI multiplied by 2." },

    { :name        => :random,
      :alias       => :rand,
      :arg         => 1,
      :examples    => ['RANDOM X', 'RAND X'],
      :description => "Returns a random number from 1 to X." },

    { :name        => :make,
      :arg         => 2,
      :examples    => ['MAKE A B'],
      :description => "Set the token A to the value B." },

    { :name        => :repeat,
      :arg         => 2,
      :store       => true,
      :examples    => ['REPEAT A [ B ]'],
      :description => "Execute the command group B, A number of times." },

    { :name        => :command,
      :arg         => 3,
      :store       => true,
      :examples    => ['COMMAND A [ B C ] [ D ]'],
      :description => "Create command A with arguments B and C to execute command group D." },

    { :name        => :same,
      :arg         => 1,
      :examples    => ['SAME [ A B ]'],
      :description => "Return true if A and B are the same." },

    { :name        => :different,
      :alias       => :diff,
      :arg         => 1,
      :examples    => ['DIFFERENT [ A B ]', 'DIFF [ A B ]'],
      :description => "Return true if A and B are different." },

    { :name        => :more,
      :arg         => 1,
      :examples    => ['MORE [ A B ]'],
      :description => "Return true if A is greater than B." },

    { :name        => :less,
      :arg         => 1,
      :examples    => ['LESS [ A B ]'],
      :description => "Return true if A is less than B." },

    { :name        => :if,
      :arg         => 2,
      :examples    => ['IF [ A ] [ B ]'],
      :description => "Execute command group B if group A evaluates to true." },

    { :name        => :ifelse,
      :arg         => 3,
      :examples    => ['IFELSE [ A ] [ B ] [ C ]'],
      :description => "Execute command group B if group A evaluates to true, otherwise execute command group C." }

  ]

end
