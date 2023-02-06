require_relative "./node.rb"

class Bst
    def initialize(array)
        @array = clean_array(array)
        @root = build_tree
       
    end

    def clean_array(array)
        array.sort!.uniq!
    end

    def build_tree(current_array = @array, start_index =0, end_index = @array.length-1)
        return if start_index > end_index
        mid = (start_index + end_index)/2
        root = Node.new(current_array[mid])
        root.is_left = build_tree(current_array, start_index, mid-1)
        root.is_right = build_tree(current_array, mid +1, end_index)
        return root
        

    end
    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.is_right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.is_right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.is_left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.is_left
    end

    def insert(value, current_node = @root)
        if current_node.nil?
            p current_node
            return false
        elsif value > current_node.data
            if !(insert(value, current_node.is_right))
                current_node.is_right = Node.new(value)
                p current_node.data 
            end
        elsif value < current_node.data
            if !(insert(value, current_node.is_left))
                current_node.is_left = Node.new(value)
                p current_node.data
            end
        end
        return true      #Reset the boolean or else it will not work
        

        
    end

    def delete(value, current_node = @root, state = false)
        if value == current_node.data
            state = true
            p "found ya"
            if !(current_node.is_right.nil?) && !(current_node.is_left.nil?)
                p " both kids"
                current_node.data = find_next_biggest_node(current_node)
                

                return 
            elsif current_node.is_right.nil? && current_node.is_left.nil?
                p"both no kids"
                return
            else 
                current_node.is_right.nil? ? (p "right no kids") : (p "left no kids")
                return
            end

            return













        elsif value > current_node.data
            delete(value, current_node.is_right) unless current_node.is_right.nil?
            p current_node.data
        elsif value < current_node.data
            delete(value, current_node.is_left) unless current_node.is_left.nil?
            p current_node.data
        end

        if !state
            return state
        end

    end
    



end
array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Bst.new(array)
p "Raw tree"
tree.pretty_print
tree.insert(6)
p "after insert"

tree.pretty_print
if !(tree.delete(7))
    p "Didn't find ya"
end

