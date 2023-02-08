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
            return false
        elsif value > current_node.data #If value is greater than current, go to right node recursively
            if !(insert(value, current_node.is_right))
                current_node.is_right = Node.new(value)
                # p current_node.data 
            end
        elsif value < current_node.data #if value is smaller than current, go to left node recursively
            if !(insert(value, current_node.is_left))
                current_node.is_left = Node.new(value)
                # p current_node.data
            end
        end
        return true      #Reset the boolean or else it will not work
        

        
    end

    def find(value, current_node = @root)
        if current_node.nil? 
            return 
        end#If current tree is nil(empty
        if value == current_node.data
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
                 
                leftmost_node = leftmost_leaf(current_node.is_right)
                current_node.data = leftmost_node.data
                delete(leftmost_node.data, current_node.is_right)



            #case 2: node has neither is_left nor is_right
            elsif current_node.is_right.nil? && current_node.is_left.nil?
                
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
                    current_node.is_left = current_node.is_right.is_left unless !(current_node.is_right.is_left)
                    current_node.is_right = current_node.is_right.is_right unless !(current_node.is_right.is_right)
                    if (current_node.is_right.is_left == nil)
                        current_node.is_left = nil
                    end
                    if (current_node.is_right.is_right == nil)
                        current_node.is_right = nil
                    end
                    
                 

                    return
                
                
                
                
                end









                
            
            end
            return
        elsif value > current_node.data
            delete(value, current_node.is_right, pre_next_biggest_node) unless current_node.is_right.nil?
        elsif value < current_node.data
            delete(value, current_node.is_left, pre_next_biggest_node) unless current_node.is_left.nil?
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


    def preorder(current_node = @root, create_array = false, array = [])
        if create_array == true
                            
            array<< current_node.data
            print "#{current_node.data}, "
            preorder(current_node.is_left, true, array) unless current_node.is_left.nil?
            preorder(current_node.is_right, true, array) unless current_node.is_right.nil?
            return array
        
        else
            print "#{current_node.data}, "
            preorder(current_node.is_left) unless current_node.is_left.nil?
            preorder(current_node.is_right) unless current_node.is_right.nil?

        end


    end

    def postorder(current_node = @root)
        postorder(current_node.is_left) unless current_node.is_left.nil?
        postorder(current_node.is_right) unless current_node.is_right.nil?
        print "#{current_node.data}, "
    end 

    def height(value, current_node = @root, matched_node = current_node)
        if current_node.nil?
            return
        end
        if value == current_node.data

            left_height = matched_node.is_left.nil? ? 0 : height(value, current_node, matched_node.is_left)
            right_height = matched_node.is_right.nil? ? 0 : height(value, current_node, matched_node.is_right)
            return left_height > right_height ? left_height + 1 : right_height + 1
            # return current_node
        elsif value < current_node.data
            
            height(value, current_node.is_left)
        elsif value > current_node.data
            
            height(value, current_node.is_right)

        end

        
    end
    def depth(value, current_node = @root, depth = 1)
        if value == current_node.data || current_node.nil?
            
            
            
            return depth
        elsif value < current_node.data
            
            height(value, current_node.is_left, depth + 1)
        elsif value > current_node.data
            
            height(value, current_node.is_right, depth + 1)

        end

        
    end

    def balanced?(current_node = @root)
        #Continue heading down nodes until it reaches a node with 1 or 0 children
        #It will return true until it comes back to a node with 2 children.
        #The node with 2 children will now be tested for height of the left and right child.
        #If there is a false at any point, then ALL future conditions will be false, otherwise it is true and balanced

        return true if current_node.is_left.nil? || current_node.is_right.nil?          
        
        return true if balanced?(current_node.is_left) &&
                       balanced?(current_node.is_right) &&
                       (height(current_node.is_left.data, current_node.is_left) - height(current_node.is_right.data, current_node.is_right)).abs <= 1
    
        false
    end

    def rebalance(current_node = @root, array = [])
        array = preorder(current_node, createArray=true)
        puts "\n#{array}"
        array.sort!.uniq!
        return array

    end
end
