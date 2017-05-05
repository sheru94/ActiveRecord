require "byebug"
class PolyTreeNode
  attr_accessor :value , :parent , :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)

    old_parent = @parent
    if new_parent.nil?
      old_parent.children.delete(self) unless old_parent.nil?
      @parent = new_parent
    else
      old_parent.children.delete(self) unless old_parent.nil?
      @parent = new_parent
      old_parent = @parent
      new_parent.children << self unless new_parent.children.include?(self)
    end
  end

  def remove_child(child_node)
    child_node.parent = nil
    raise "#{child_node} is not your child" if !self.children.include?(child_node)
  end

  def add_child(child_node)
     child_node.parent = self
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      result = child.dfs(target)
      return result if !result.nil?
    end
    nil
  end

  def bfs(target)
    q =[self]

    until q.empty?
      first = q.shift
      if first.value == target
        return first
      else
        q += first.children
      end
    end
    nil
  end








end
