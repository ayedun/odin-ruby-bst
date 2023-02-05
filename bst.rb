require_relative "./node.rb"

class Bst
    def initialize(array)
        @array = clean_array(array)
        @root = build_tree
        p @array
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
    



end
array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Bst.new(array)
tree.pretty_print

