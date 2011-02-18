class GenericMatrix
    @matrix
    
    def initialize(n)
        @matrix = []

        data = nil
        if (n.kind_of? Array)
            data = n
            n = data.length
        end

        fill_zero(n)

        if not (data.nil?)
            set_array(data)
        end
    end

    def get(x, y)
        @matrix[x][y]
    end

    def set(x, y, value)
        @matrix[x][y] = value
    end

    def set_array(data)
        data.each_index { |y| data[y].each_index { |x| set(x, y, data[y][x])}}
    end

    def fill_zero(n)
        @matrix = []
        n.times do 
            line = []
            n.times { line << 0 }
            @matrix << line
        end
    end
end
