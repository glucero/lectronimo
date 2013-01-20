class Lectronimo

  include Vocabulary,
          Spectrum,
          Body,
          LeftBrain,
          RightBrain

  def initialize
    @paths   = []
    @binding = [] # user created commands and variable container

    Commands.each do |command|
      command[:call] = ->(*arguments) do
        send(command[:name], *arguments)
      end
    end

    # set lectronimo's defaults
    start_path App.center
    pencolor   :black
    pensize    1.0
    heading    0.0
    pendown
    show
  end

  def binding
    @binding
  end

  def lookup(symbol)
    Commands.find { |cmd| cmd[:name] == symbol || cmd[:alias] == symbol } or
    @binding.find { |cmd| cmd[:name] == symbol }
  end

  def run(snippet)
    execute Parser.read(snippet).commands
  rescue => error
    Popup.initWithMessage(error.message, title: error.class)
  end

  def single(commands)
    execute(commands).shift
  end

  def multiple(values)
    execute(values).flatten
  end

  def execute(commands)
    [].tap do |result|
      if commands.is_a? Array
        until commands.empty?
          result << evaluate(commands)
        end
      else
        result << evaluate(commands)
      end
    end
  end

  def unnest(commands)
    commands.is_a?(Array)? commands.shift : commands
  end

  def evaluate(commands)
    token = unnest(commands)

    if function = lookup(token)
      arguments = function[:arg].times.map do
        function[:store] ? unnest(commands) : evaluate(commands)
      end

      function[:call][*arguments]
    else
      token
    end
  end

  # aliases
  alias sub   subtract
  alias mul   multiply
  alias div   divide
  alias abs   absolute
  alias pow   power
  alias mod   modulo
  alias sin   sine
  alias cos   cosine
  alias tan   tangent
  alias asin  arcsine
  alias acos  arccosine
  alias atan  arctangent
  alias log   logarithm
  alias sqrt  squareroot
  alias cbrt  cuberoot
  alias hypot hypotenuse
  alias diff  different
  alias pu    penup
  alias pd    pendown
  alias ps    pensize
  alias pc    pencolor
  alias go    goto
  alias fd    forward
  alias bk    back
  alias rt    right
  alias lt    left

end

