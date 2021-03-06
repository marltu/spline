require 'gnuplot'

require './spline'
require './point_generator'

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
  
#    plot.xrange "[-10:10]"
    plot.ylabel "y"
    plot.xlabel "x"

    draw_compare = false
    accuracy = 10000


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

    # collect generated dada
    x = range.step((range.end - range.begin).fdiv(accuracy)).collect { |v| v.to_f }
    y = x.collect { |v| sp.eval(v) }
    
    plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
      ds.with = "lines"
      ds.linewidth = 1
      ds.title = "generated"
    end

    if (not skip_real)
        # real data
        x = range.step((range.end - range.begin).fdiv(accuracy)).collect { |v| v.to_f }
        y = x.collect { |v| f.call(v) }
        
        plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
          ds.with = "lines"
          ds.linewidth = 1
          ds.title = "real"
        end
    end



    # data of used points
    x = points.each.collect { |p| p.x }
    y = points.each.collect { |p| p.y }

    plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
      ds.with = "points"
#      ds.linewidth = #1
      ds.title = "data points"
    end
    


    
  end
  
end
