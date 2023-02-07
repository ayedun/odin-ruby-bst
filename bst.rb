require_relative "./node.rb"

class Bst
    #initialize tree with original mid as main root
    def initialize(array)
        @array = clean_array(array)
        @root = build_tree
       
    end
    #clean array from duplicates and sort them
    def clean_array(array)
        array.sort!.uniq!
        array
    end
    #Build tree from cleaned array
    def build_tree(current_array = @array, start_index =0, end_index = @array.length-1)
        return if start_index > end_index   #Base case: when we only have 1  array element left, turn into node.
        mid = (start_index + end_index)/2   #root is mid of array
        root = Node.new(current_array[mid]) 
        root.is_left = build_tree(current_array, start_index, mid-1) #left half of array becomes left node, and right half of array becomes right node
        root.is_right = build_tree(current_array, mid +1, end_index)
        return root
        

    end
    #Sourced from TOP to print the tree 
    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.is_right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.is_right && node.is_right != nil 
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.is_left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.is_left && node.is_left != nil 
    end
    #insert a value into the tree   
    def insert(value, current_node = @root)
        if current_node.nil? #If current tree is nil(empty), insert
            p current_node
            return false
        elsif value > current_node.data #If value is greater than current, go to right node recursively
            if !(insert(value, current_node.is_right))
                current_node.is_right = Node.new(value)
                p current_node.data 
            end
        elsif value < current_node.data #if value is smaller than current, go to left node recursively
            if !(insert(value, current_node.is_left))
                current_node.is_left = Node.new(value)
                p current_node.data
            end
        end
        return true      #Reset the boolean or else it will not work
        

        
    end

    def find(value, current_node = @root)
        if value == current_node.data || current_node.nil?
            return current_node
        elsif value < current_node.data
            find(value, current_node.is_left)
        elsif value > current_node.data
            find(value, current_node.is_right)
        end



        
    end

    #To get letmost_leaf
    def leftmost_leaf(node)
        
        node = node.is_left until node.is_left.nil?
    
        node
    end


    def delete(value, current_node = @root, state = false, pre_next_biggest_node = nil)
 

        
        



        if value == current_node.data   #base case: Value matches, delete
            state = true
            #Case 1: node has both is_left and is_right
            if !(current_node.is_right.nil?) && !(current_node.is_left.nil?)
                p " both kids"  
                leftmost_node = leftmost_leaf(current_node.is_right)
                current_node.data = leftmost_node.data
                delete(leftmost_node.data, current_node.is_right)



            #case 2: node has neither is_left nor is_right
            elsif current_node.is_right.nil? && current_node.is_left.nil?
                p"both no kids"
                current_node.data = nil










            #case 3: node has either is_left or is_right
            else 
                current_node.is_right.nil? ? (side = "left") : (side = "right")

                if side == "left"
                    current_node.data =current_node.is_left.data
                    current_node.is_left =current_node.is_left.is_left unless !(current_node.is_left.is_left)
                    current_node.is_right = current_node.is_left.is_right unless !(current_node.is_left.is_right)
                   
                    if (current_node.is_left.is_right == nil)
                        current_node.is_right = nil
                    end

                    if (current_node.is_left.is_left == nil)
                        current_node.is_left = nil
                    end
                    return
                    
                
                
                
                elsif side == "right"
                    current_node.data = current_node.is_right.data
                    p current_node.is_right.is_left
                    current_node.is_left = current_node.is_right.is_left unless !(current_node.is_right.is_left)
                    current_node.is_right = current_node.is_right.is_right unless !(current_node.is_right.is_right)
                    p current_node
                    if (current_node.is_right.is_left == nil)
                        current_node.is_left = nil
                    end
                    if (current_node.is_right.is_right == nil)
                        current_node.is_right = nil
                    end
                    p current_node
                 

                    return
                
                
                
                
                end









                
            
            end
            return
        elsif value > current_node.data
            delete(value, current_node.is_right, pre_next_biggest_node) unless current_node.is_right.nil?
            p current_node.data
        elsif value < current_node.data
            delete(value, current_node.is_left, pre_next_biggest_node) unless current_node.is_left.nil?
            p current_node.data
        end
        if !state
            return state
        end
    end

    def level_order(current_node = @root, queue = Queue.new())

        print "#{current_node.data}, "
        queue.enq(current_node.is_left) unless current_node.is_left.nil?
        queue.enq(current_node.is_right) unless current_node.is_right.nil?
        level_order(queue.deq, queue) unless queue.empty?
        if queue.empty?
            return
        end

    end

    def inorder(current_node = @root)
        inorder(current_node.is_left) unless current_node.is_left.nil?
        print "#{current_node.data}, "
        inorder(current_node.is_right) unless current_node.is_right.nil?
        

    end


    def preorder(current_node = @root)
        print "#{current_node.data}, "
        preorder(current_node.is_left) unless current_node.is_left.nil?
        preorder(current_node.is_right) unless current_node.is_right.nil?

    end

    def postorder(current_node = @root)
        postorder(current_node.is_left) unless current_node.is_left.nil?
        postorder(current_node.is_right) unless current_node.is_right.nil?
        print "#{current_node.data}, "
    end 

    def height(value, current_node = @root, matched_node = current_node)
        if value == current_node.data || current_node.nil?

            left_height = matched_node.is_left.nil? ? 0 : height(value, current_node, matched_node.is_left)
            right_height = matched_node.is_right.nil? ? 0 : height(value, current_node, matched_node.is_right)
            return left_height > right_height ? left_height + 1 : right_height + 1





            left_height >= right_height ? (p "The height of the node is #{left_height}") : (p "The height of the node is #{right_height}")
            return current_node
        elsif value < current_node.data
            
            height(value, current_node.is_left)
        elsif value > current_node.data
            
            height(value, current_node.is_right)

        end

        
    end



end
array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# array = ["A", "B", "C", "D", "E", "F", "G", "I", "J", "K"]
tree = Bst.new(array)
p "Raw tree"
tree.pretty_print
tree.insert(6)
p "after insert"

tree.pretty_print

if !(tree.delete(9))
    p "Didn't find ya"
end

p "after delete"
tree.pretty_print
p tree.find(5)

tree.level_order
tree.pretty_print
p "Preorder: #{tree.preorder}"
p "Inorder: #{tree.inorder}"
p "Postorder: #{tree.postorder}"
p " Height: #{tree.height(5)}"


