class Parser

  def self.read(snippet)
    Parser.new(snippet).tap do |parser|
      parser.parse
      parser.organize
    end
  end

  def initialize(snippet)
    @snippet = snippet
  end

  def commands
    @commands ||= []
  end

  def parse
    @tokens ||= @snippet.split(/(!?\[)|(!?\])|\s/).map do |token|
      unless token.empty?
        if token[/[0-9]+(\.[0-9]+)?/]
          token.to_f
        else
          token.downcase.to_sym
        end
      end
    end.compact
  end

  def organize
    until @tokens.empty?
      token = @tokens.shift

      if token == :'['
        commands << nested(@tokens)
      else
        commands << token
      end
    end
  end

  def nested(stack, delimiter = :open)
    [].tap do |tokens|

      loop do
        if stack.empty?
          break
        else
          token = stack.shift

          case token
          when :'['
            tokens << nested(stack)
          when :']'
            break
          else
            tokens << token
          end
        end
      end
    end
  end

end
