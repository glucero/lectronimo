module LeftBrain

  include Vocabulary

  def add(values)
    multiple(values).inject(&:+)
  end

  def subtract(values)
    multiple(values).inject(&:-)
  end

  def multiply(values)
    multiple(values).inject(&:*)
  end

  def divide(values)
    multiple(values).inject(&:/)
  end

  def absolute(value)
    single(value).abs
  end

  def power(values)
    multiple(values).inject(&:**)
  end

  def modulo(values)
    multiple(values).inject(&:%)
  end

  def sine(value)
    Math.sin single(value)
  end

  def cosine(value)
    Math.cos single(value)
  end

  def tangent(value)
    Math.tan single(value)
  end

  def arcsine(value)
    Math.asin single(value)
  end

  def arccosine(value)
    Math.acos single(value)
  end

  def arctangent(value)
    Math.atan single(value)
  end

  def squareroot(value)
    Math.sqrt single(value)
  end

  def cuberoot(value)
    Math.cbrt single(value)
  end

  def logarithm(value)
    Math.log single(value)
  end

  def hypotenuse(values)
    Math.hypot *multiple(values)[0..1]
  end

  def random(value)
    rand(single value) + 1
  end

  def degree
    pi / 180
  end

  def pi
    Math::PI
  end

  def phi
    (1 + Math.sqrt(5)) / 2
  end

  def euler
    Math::E
  end

  def bind(name, arguments, function)
    @binding.reject! { |cmd| cmd[:name] == name }
    @binding << { :name => name,
                  :arg  => arguments,
                  :call => function }
  end

  def make(variable, value)
    value    = evaluate(value)
    function = ->(*arguments) { value }

    bind(variable, 0, function)
  end

  def repeat(iterations, commands)
    iterations = evaluate(iterations).to_i
    iterations.times { execute Marshal.load(Marshal.dump commands) }
  end

  def substitute(command, variables, arguments)
    if command.is_a? Array
      command.map { |cmd| substitute(cmd, variables, arguments) }
    else
      if index = variables.find_index(command)
        arguments[index]
      else
        command
      end
    end
  end

  def command(command, variables, commands)
    function = ->(*arguments) do
      execute Marshal.load(Marshal.dump commands).map do |command|
        substitute(command, variables, arguments)
      end
    end

    bind(command, variables.count, function)
  end

  def if(test, success)
    evaluate(test) and execute(success)
  end

  def ifelse(test, success, failure)
    evaluate(test) ? execute(success) : execute(failure)
  end

  def more(args)
    multiple(args).inject(&:>)
  end

  def less(args)
    multiple(args).inject(&:<)
  end

  def same(args)
    multiple(args).inject(&:==)
  end

  def different(args)
    multiple(args).inject(&:!=)
  end

end


