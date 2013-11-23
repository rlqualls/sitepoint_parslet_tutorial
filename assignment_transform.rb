# assignment_transform.rb
require 'parslet'

tree = [{:assignment=>{:left=>"a", :right=>"23"}}, {:assignment=>{:left=>"b", :right=>"56"}}]

class Assignment
  def initialize(left, right)
    @left = left
    @right = right
  end

  def generate_code
    # spit out bytecode/machinecode associated with assignment operation
  end
end

class AssignmentTransform < Parslet::Transform
  rule(:left => simple(:left), :right => simple(:right)) do 
    Assignment.new(left, Integer(right))
  end
end

transform = AssignmentTransform.new
puts transform.apply(tree).inspect
