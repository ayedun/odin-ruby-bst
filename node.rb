class Node
    attr_accessor :data, :is_left, :is_right
    def initialize(value)
        @data= value
        @is_left= nil
        @is_right= nil
    end
end
