class Lectronimo

  include Vocabulary
  include Spectrum

  include Body
  include LeftBrain
  include RightBrain

  def initialize
    @paths   = Array.new
    @binding = Array.new # user created commands and variable container

    Commands.each do |command|
      command[:call] = ->(*call) do
        send(command[:name], *call)
      end
    end

    # set lectronimo's defaults
    start_path App.center
    pencolor :black
    pensize 1.0
    heading 0.0
    pendown
    show
  end

  def lookup(symbol)
    Commands.find { |c| c[:name].eql?(symbol) || c[:alias].eql?(symbol) } or
    @binding.find { |c| c[:name].eql?(symbol) }
  end

  def run(snippet)
    execute Parser.read(snippet)
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
    Array.new.tap do |result|
      if commands.is_a? Array
        until commands.empty?
          result.push evaluate(commands)
        end
      else
        result.push evaluate(commands)
      end
    end
  end

  def nested(commands)
    if commands.is_a? Array
      commands.shift
    else
      commands
    end
  end

  def evaluate(commands)
    token = nested(commands)

    if function = lookup(token)
      arguments = if function[:store]
                    function[:arg].times.map do
                      nested(commands)
                    end
                  else
                    function[:arg].times.map do
                      evaluate(commands)
                    end
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

