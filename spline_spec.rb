require "./spline"
require "./point"

describe Spline do
    it "should initialize with point" do
        Spline.new([Point.new(0,0)])
    end
end
