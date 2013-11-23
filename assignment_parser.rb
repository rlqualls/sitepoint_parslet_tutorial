# assignment_parser.rb
require 'parslet'

class AssignmentParser < Parslet::Parser
  rule(:identifier) { match('[a-zA-Z0-9_]').repeat(1) }
  rule(:value) { match('[0-9]').repeat(1) }
  rule(:assignment) { 
    identifier.as(:left) >> 
    str('=') >> 
    value.as(:right) >> 
    str("\n").maybe 
  }
  rule(:assignments) { assignment.as(:assignment).repeat }
  root(:assignments)
end

doc = <<-eof
a=23
b=56
eof

parser = AssignmentParser.new
puts parser.parse(doc).inspect
