class Lectronimo

  include Vocabulary,
          Spectrum,
          Body,
          LeftBrain,
          RightBrain

  def initialize
    # set lectronimo's defaults
    Commands.each { |command| bind command } # learn the default commands

    start    App.center
    pencolor :black
    pensize  1.0
    heading  0.0
    pendown
    show
  end

  def memory
    @memory ||= {}
  end

  def forget
    memory.clear and Commands.each { |command| bind command }
  end

  def bind(command)
    [:name, :alias].each do |key|
      if name = command[key]
        memory[name] = command

        unless memory[name][:function]
          memory[name][:function] = ->(*arguments) do
            send command[:name], *arguments
          end
        end
      end
    end
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

  def evaluate(commands)
    token = commands.is_a?(Array)? commands.shift : commands

    if function = memory[token]
      arguments = function[:args].times.map do
        if token =~ /command|repeat/
          commands.is_a?(Array)? commands.shift : commands
        else
          evaluate commands
        end
      end

      function[:function][*arguments]
    else
      token
    end
  end

end

