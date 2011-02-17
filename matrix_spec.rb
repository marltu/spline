require './matrix'

describe Matrix do
    it "should initialize with 2" do
        Matrix.new(2)
    end
    it "should return 0 when no other values are set" do
        m = Matrix.new(2)
        m.get(0, 0).should == 0
        m.get(1, 1).should == 0
    end
    it "should return setted values" do
        m = Matrix.new(5)
        m.set(1, 2, 15)
        m.get(1, 2).should == 15
        m.get(2, 1).should == 0
    end

    it "should set matrix using array" do
        m = Matrix.new([
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ])

        m.get(1, 1).should == 5

    end
end
