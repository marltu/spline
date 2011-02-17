require './point'

describe Point do
    it "should initialize with 0, 0" do
        Point.new(0, 0)
    end

    it "should store values for retrieval" do
        p = Point.new(1, 2)
        p.x.should == 1
        p.y.should == 2
    end

    it "should set values" do
        p = Point.new(1, 2)
        p.x = 3
        p.y = 4
        p.x.should == 3
        p.y.should == 4
    end

end
