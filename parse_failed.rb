# parse_failed.rb
require 'parslet'

class FailParser < Parslet::Parser
  rule(:alpha) { match('[a-zA-Z]').repeat(1) }
  rule(:number) { digit.repeat(1) >> (str('.') >> digit.repeat(1)).maybe }
  rule(:digit) { match('[0-9]').repeat(1) }
  rule(:space) { str(' ') }
  rule(:line) { alpha >> space >> number >> space >> alpha }

  root(:line)
end

input = "ab 1.2 d1"
parser = FailParser.new

# not so great error reporting
puts "--STANDARD ERROR REPORTING--"
begin
  parser.parse(input)
rescue Exception => error
  puts error
end

puts ("\n")

# better error reporting
puts "--ASCII TREE ERROR REPORTING--"
begin
  parser.parse(input)
rescue Parslet::ParseFailed => error
  puts error.cause.ascii_tree
end
