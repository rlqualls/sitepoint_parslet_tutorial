# demo_transform.rb
require 'parslet'

tree = {
  :left => {:string => "hello world"},
  :right => {:array  => "['a', 'b', 'c']"},
}

class DemoTransform < Parslet::Transform
  rule(:string => simple(:s)) { s.upcase }
  rule(:array => sequence(:arr)) { puts arr.inspect }
end

transform = DemoTransform.new
puts "Transformed Tree:"
puts transform.apply(tree).inspect
