require './generic_matrix'

describe GenericMatrix do
    it "should initialize with 2" do
        GenericMatrix.new(2)
    end
    it "should return 0 when no other values are set" do
        m = GenericMatrix.new(2)
        m.get(0, 0).should == 0
        m.get(1, 1).should == 0
    end
    it "should return setted values" do
        m = GenericMatrix.new(5)
        m.set(1, 2, 15)
        m.get(1, 2).should == 15
        m.get(2, 1).should == 0
    end

    it "should set matrix using array" do
        m = GenericMatrix.new([
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ])

        m.get(1, 1).should == 5

    end
end
