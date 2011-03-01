require "./tridiagonal_matrix"
require "./interval_function"

class Spline
    @points
    @g
    @S

    def initialize(points)
        @points = points     
    end

    def g
        # calculates g when needed
        @g ||= calculate_g
    end

    def S
        @S ||= create_S
    end

    def calculate_g
        last = @points.length - 1
                
        matrix = TridiagonalMatrix.new(@points.length)
        matrix.set_b(0, 1)
        matrix.set_c(0, 0)

        eq = [0]

        1.upto(last-1) do |i|
            matrix.set_a(i, h(i-1))
            matrix.set_b(i, 2 * ( h(i-1) + h(i) ) )
            matrix.set_c(i, h(i))

            eq.push(
                6 *                               \
                (                                 \
                    (y(i+1) - y(i)).fdiv(h(i))    \
                    -                             \
                    (y(i) - y(i-1)).fdiv(h(i-1))  \
                )                                 \
            )
        end

        matrix.set_a(last, 0)
        matrix.set_b(last, 1)
        eq.push(0)

        matrix.solve(eq)
    end

    def create_S
        0.upto(@points.length - 2).collect do |i|
            IntervalFunction.new(
                y(i),
                e(i),
                G(i),
                H(i),
                @points[i].x,
                Range.new(@points[i].x, @points[i+1].x, !(i == @points.length - 2))
            )
        end
    end

    def eval(x)
        S().each do |s| 
            if (s.covers?(x)) 
                return s.eval(x)
            end
        end

        return nil
    end 

    def h(i)
        @points[i+1].x - @points[i].x
    end

    def y(i)
        @points[i].y
    end

    def e(i)
        (y(i+1) - y(i)).fdiv(h(i)) -    \
        g[i+1] * h(i)/6 -               \
        g[i] * h(i)/3
    end

    def G(i)
        g[i]/2
    end

    def H(i)
        (g[i+1] - g[i])/6/h(i)
    end
end
