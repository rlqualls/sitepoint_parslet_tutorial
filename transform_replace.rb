# transform_replace.rb
require 'parslet'

ast = {:document => {:words => "hello world"}}

# replaces the words node
class LeafTransform < Parslet::Transform
  rule(:words => simple(:x)) { x.upcase }
end

# replaces document and words nodes
class TreeTransform < Parslet::Transform
  rule(:document => {:words => simple(:x)}) { x.upcase }
end

leaf_transform = LeafTransform.new
puts leaf_transform.apply(ast).inspect

tree_transform = TreeTransform.new
puts tree_transform.apply(ast).inspect
