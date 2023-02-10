class Node  
  attr_reader :position, :parent
  TRANSFORMATIONS = [[1,2],[1,-2],[2,1],[2,-1],[-1,2],[-1,-2],[-2,1],[-2,-1]]
  @@history = []
  def initialize(position,parent)
    @position = position
    @parent = parent
    @@history.push(position)
  end
  def self.valid?(position)
    position[0].between?(1,8) && position[1].between?(1,8)
  end
  def children
    TRANSFORMATIONS.map {|i| [position[0] + i[0], position[1] + i[1]] }
    .keep_if { |e| Node.valid?(e) }
    .reject { |e| @@history.include?(e) }
    .map { |e| Node.new(e,self) }
  end
end

def display(node)
  display(node.parent) unless node.parent.nil?
  p node.position
end

def knight_moves(start_pos,end_pos)
  queue = []
  current_node = Node.new(start_pos,nil)
  until current_node.position == end_pos
    current_node.children.each { |child| queue.push(child) }
    current_node = queue.shift
  end
  display(current_node)
end
knight_moves([1, 1], [8, 8])