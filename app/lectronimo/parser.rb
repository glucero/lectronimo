class Parser

  def self.read(snippet)
    parser = Parser.new(snippet)
    parser.parse
    parser.organize
    parser.commands
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
        if token[/#{token.to_f}|#{token.to_i}/]
          token.to_f
        else
          token.to_s.downcase.to_sym
        end
      end
    end.compact
  end

  def organize
    until @tokens.empty?
      token = @tokens.shift

      case token
      when :'['
        commands.push nested(@tokens)
      else
        commands.push token
      end
    end
  end

  def nested(stack, delimiter = :open)
    Array.new.tap do |tokens|

      until delimiter.eql? :close

        if stack.empty?
          delimiter = :close
        else
          token = stack.shift

          case token
          when :'['
            tokens.push nested(stack)
          when :']'
            delimiter = :close
          else
            tokens.push(token)
          end
        end
      end
    end
  end

end
