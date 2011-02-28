require './spline'
require './point_generator'

draw_compare = false

if draw_compare
#        range = 0..6
#        f = lambda {|x| x**3 - 5* x**2 + 3 * x + 4}
    range = -2..3
    f = lambda {|x| (1-x).fdiv(4+x**2)}
    points = PointGenerator.new(f).generate(11, range)
    skip_true = false
else
    range = 0..5
    points = PointGenerator.new(12).generate(6, range)
    skip_real = true
end

sp = Spline.new(points)    

require 'rubygems'
require 'ripl'
Ripl.start :binding => binding
