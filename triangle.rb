# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  # WRITE THIS CODE
  sides = [ a, b, c ]
  raise TriangleError.new unless is_triangle?(sides)
  return :equilateral if sides.count(a) == 3
  return :isosceles if sides.any? { |s| sides.count(s) == 2 }
  :scalene
end

def is_triangle?(sides)
  a, b, c = sides
  # Triangle Inequality Theorem
  a + b > c && a + c > b && b + c > a && sides.all? { |s| s > 0 }
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
