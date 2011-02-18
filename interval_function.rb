class IntervalFunction
    @y
    @e
    @G
    @H
    @range
    
    @x

    def initialize(y, e, g, h, x, range)
        @y = y
        @e = e
        @G = g
        @H = h
        @x = x

        @range = range
    end

    def covers?(x)
        @range.include? x
    end

    def eval(x)
        raise "Can't evaluate function not in range" if (not covers? x)

        @y + @e*(x-@x) + @G*(x - @x)**2 + @H*(x - @x)**3
    end

end
