require './matrix'

class TridiagonalMatrix < Matrix
    @matrix
    def fill_zero(n)
        @matrix = []
        n.times { @matrix << [0, 0, 0] }
    end

    def get(x, y)
        if (x - y).abs > 1
            return 0
        else
            return @matrix[y][x-y + 1]
        end
    end
    def set(x, y, value)
        raise RangeError, "can't set value not in triagonal with non-zero value" if (x - y).abs > 1 and value != 0

        if not (value == 0 and (x - y).abs > 1)
            @matrix[y][x-y + 1] = value
        end
    end

    def set_a(y, value)
        @matrix[y][0] = value
    end
    def get_a(y)
        @matrix[y][0]
    end

    def set_b(y, value)
        @matrix[y][1] = value
    end
    def get_b(y)
        @matrix[y][1]
    end
    
    def set_c(y, value)
        @matrix[y][2] = value
    end
    def get_c(y)
        @matrix[y][2]
    end

    def diagonally_dominant?
        @matrix.each_index do |y|
            if (get_b(y).abs < get_a(y).abs + get_c(y).abs) 
                return false
            end
        end

        return true
    end

    def determinate(d)
        if d.length != @matrix.length
            raise ArgumentError, "invalid number of parameters given. Got #{d.length} but should be #{@matrix.length}"
        end

        raise "Matrix is not diagonally dominant, can't solve" if not diagonally_dominant?

        return tdma(d)
    end

    private
    def tdma(d)
        (@matrix.length - 1).downto(0).collect { |k| tdma_x(k, d) }.reverse
    end

    def tdma_x(k, d)
        if (k == (@matrix.length() -1))
            tdma_d(k, d)
        else
            tdma_c(k) * tdma_x(k+1, d) + tdma_d(k, d)
        end
    end

    def tdma_c(k)
        if k == 0
            -get_c(k).fdiv(get_b(k))
        else
            -get_c(k).fdiv(tdma_cd_partial(k))
        end
    end

    def tdma_d(k, d)
        if k == 0
            d[k].fdiv get_b(k)
        else
            (d[k] - get_a(k)*tdma_d(k-1, d)).fdiv(tdma_cd_partial(k))
        end
    end


    def tdma_cd_partial(k)
        get_a(k) * tdma_c(k-1) + get_b(k)
    end
end