class BinaryTree
  require_relative 'student'
  require 'date'
  include Enumerable

  class Node
    attr_reader :student, :left, :right

    def initialize(student)
      @student = student
      @left = nil
      @right = nil
    end

    def insert(new_student)
      if new_student.birth_date <= @student.birth_date
        @left ? @left.insert(new_student) : @left = Node.new(new_student)
      else
        @right ? @right.insert(new_student) : @right = Node.new(new_student)
      end
    end
  end

  def initialize
    @root = nil
  end

  def add(student)
    if @root.nil?
      @root = Node.new(student)
    else
      @root.insert(student)
    end
  end

  def each(&block)
    return to_enum(:each) unless block_given?

    in_order_traversal(@root, &block)
  end

  private

  def in_order_traversal(node, &block)
    return if node.nil?

    in_order_traversal(node.left, &block)
    yield node.student
    in_order_traversal(node.right, &block)
  end
end