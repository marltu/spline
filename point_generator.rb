require './point'

class PointGenerator
    @function

    def initialize(arg)
        # special case for using number in list for determining points
        # take number in list, convert it to string len 6 of binary,
        # first letter in string is x = 0. When letter is 0 => y = 0
        # when letter is 1 => y = 209
        if arg.kind_of? Integer
            function = lambda do |x|
                v = arg.to_s(2).rjust(6, '0')[x]
                if (v.nil? or v == "0"[0]) 
                    return 0
                else 
                    return 209
                end
            end
        else
            function = arg 
        end
        @function = function
    end

    def generate(n, range)
        range.step((range.end - range.begin).fdiv(n-1)).collect do |x|
            Point.new(x, @function.call(x)) 
        end
    end
end
