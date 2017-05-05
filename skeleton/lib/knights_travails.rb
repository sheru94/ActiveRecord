
# require_relative 'OO_tree_node.rb'

class KnightPathFinder

  def self.build_move_tree
    # add @visted_positions
    nodes = [@start_pos]
    pos = @start_pos.value
    until visted_positions.length == 64
      new_move_positions(pos).each do |move|
        new_node = PolyTreeNode.new(move)
        new_node.parent = pos
        @visted_positions << new_node.value
        nodes << new_node

      end

    end
    nodes = []
    moves.each do |pos|
      nodes << PolyTreeNode.new(pos)
    end
    nodes
  end

  def self.valid_moves(pos)
    x,y = pos
    moves = [[x+2,y+1],[x+2,y-1], [x-2,y+1], [x-2,y-1], [x+1,y+2], [x+1,y-2], [x-1,y+2], [x-1,y-2]]
    KnightPathFinder.is_valid_move?(moves)
  end

  def self.is_valid_move?(moves)
    moves.select do |move|
      move.all? {|coor| (0..7).include?(coor) }
    end
  end

  attr_accessor :start_pos, :visted_positions

  def initialize(start_pos)
    @start_pos = PolyTreeNode.new(start_pos)
    @visted_positions = [start_pos]
  end

  def new_move_positions(pos)
    new_moves = self.class.valid_moves(pos)
    new_moves.reject! { |move| visted_positions.include?(move) }
  end



end
