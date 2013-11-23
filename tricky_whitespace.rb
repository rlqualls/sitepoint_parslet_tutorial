# tricky_whitespace.rb
# Be careful with #repeat(0)
require 'parslet'

class BadWhitespaceParser < Parslet::Parser
  rule(:space) { match('\s').repeat(0) }
  rule(:identifier) { match('[a-zA-Z0-9]').repeat(1) }
  rule(:line) { identifier | space }
  rule(:lines) { (line >> space).repeat(0) }

  root(:lines)
end

doc = <<-eof
east
west
eof

parser = BadWhitespaceParser.new
# This will hang. Use ctrl-c to interrupt.
puts parser.parse(doc).inspect
