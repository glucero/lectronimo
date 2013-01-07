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
    Math.hypot *multiple(values)
  end

  def random(value)
    rand(single(value)) + 1
  end

  def degree
    Math::PI / 180
  end

  def radian
    Math::PI * 2
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

  def make(variable, value)
    value = evaluate(value)

    Vocabulary::Commands.reject! { |c| c[:name].eql? variable }
    Vocabulary::Commands.push({
      :name => variable,
      :arg  => 0,
      :call => ->(*call) { value }
    })
  end

  def repeat(iterations, commands)
    iterations = evaluate(iterations).to_i

    iterations.times do
      execute Marshal.load(Marshal.dump(commands))
    end
  end

  def command(command, variables, commands)
    Vocabulary::Commands.reject! { |c| c[:name].eql? command }
    Vocabulary::Commands.push({
      :name     => command,
      :arg      => variables.count,
      :call     => ->(*arguments) do
        function = Marshal.load(Marshal.dump(commands))

        execute function.map { |command| substitute(command, variables, arguments) }
      end
    })
  end

  def substitute(command, variables, arguments)
    if command.is_a? Array
      command.map { |c| substitute(c, variables, arguments) }
    else
      if index = variables.find_index(command)
        arguments[index]
      else
        command
      end
    end
  end

  def if(test, success)
    execute(success) if evaluate(test)
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


