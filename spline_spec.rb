require "./spline"
require "./point"
require "./point_generator"

describe Spline do
    it "should initialize with point" do
        Spline.new([Point.new(0,0)])
    end

    it "should initialize with generated points" do
        Spline.new(PointGenerator.new(lambda {|x| 2*x}).generate(10, 1..10))
    end

    it "should generate good g's for specific points" do
        spline = Spline.new([
            Point.new(0, 0),
            Point.new(1, 0.5),
            Point.new(2, 2),
            Point.new(3, 1.5)
        ])

        correct = [0, 2.4, -3.6, 0]
        real = spline.g

        diff = 0.001

        real.each_with_index { |g, i| g.should be_close(correct[i], diff) }

        spline.e(0).should be_close(0.1, diff)
        spline.e(1).should be_close(1.3, diff)
        spline.e(2).should be_close(0.7, diff)

        spline.G(0).should be_close(0, diff)
        spline.G(1).should be_close(1.2, diff)
        spline.G(2).should be_close(-1.8, diff)

        spline.H(0).should be_close(0.4, diff)
        spline.H(1).should be_close(-1, diff)
        spline.H(2).should be_close(0.6, diff)

        spline.eval(0).should == 0
        spline.eval(3).should == 1.5
        spline.eval(2.5).should be_between(1.5, 2.0)
    end
end
