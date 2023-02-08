require_relative "./bst.rb"
require_relative "./node.rb"

# Confirm that the tree is balanced by calling #balanced?


# Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })
array = Array.new(15) {rand(1..100)}
tree = Bst.new(array)
tree.pretty_print
p "Tree balanced? : #{tree.balanced?}" # Confirm that the tree is balanced by calling #balanced?

# Print out all elements in level, pre, post, and in order
p "Level_Order: #{tree.level_order}"
p "Pre_Order: #{tree.preorder}"
p "Post_Order: #{tree.postorder}"
p "In_order: #{tree.inorder}"


# Unbalance the tree by adding several numbers > 100
p"Added 105, 110, 115, 120" 
tree.insert(105)
tree.insert(110)
tree.insert(115)
tree.insert(120)


tree.pretty_print
p "Tree balanced? : #{tree.balanced?}" # Confirm that the tree is unbalanced by calling #balanced?
tree = Bst.new(tree.rebalance)
p "Balanced the tree"
tree.pretty_print

# Print out all elements in level, pre, post, and in order
p "Tree balanced? : #{tree.balanced?}"
p "Level_Order: #{tree.level_order}"
p "Pre_Order: #{tree.preorder}"
p "Post_Order: #{tree.postorder}"
p "In_order: #{tree.inorder}"
tree.pretty_print









