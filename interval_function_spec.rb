require "./interval_function"

describe IntervalFunction do
    it "creates with parameters" do
        IntervalFunction.new(1, 1, 1, 1, 1, 1..2)
    end

    it "evaluates to right values" do
        f = IntervalFunction.new(19, 30.830986, 12.253521, -4.0845070, 5, 1..4)
        f.eval(4).should be_close(4.50761, 0.001)
        lambda { f.eval(5) }.should raise_error RuntimeError
    end
end
