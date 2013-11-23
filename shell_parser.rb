# shell_parser.rb
require 'parslet'

class ShellParser < Parslet::Parser
  rule(:alphanum) { match('[/$a-zA-Z0-9\._]').repeat(1) }
  rule(:command) do 
    alphanum.as(:command) >> space? >> args.as(:args).maybe >> flags.as(:flags).maybe
  end
  rule(:args) { (alphanum.as(:arg) >> space?).repeat(0) }
  rule(:flags) { (flag.as(:flag) >> (space >> alphanum.as(:flagarg)).maybe).repeat(0) }
  rule(:flag) { str('-').repeat(1,2) >> alphanum }
  rule(:space) { str(' ').repeat(1) }
  rule(:space?) { space.maybe }
  root(:command)
end

parser = ShellParser.new
begin
  puts parser.parse("echo $EDITOR").inspect
  puts parser.parse("find /usr/lib -name libsomething.so.5").inspect
rescue Parslet::ParseFailed => error
  puts error.cause.ascii_tree
end
