require './point_generator'

describe PointGenerator do
    it "creates initializes with simple function" do
        PointGenerator.new(lambda { |x| x })
    end

    it "splits invertal in 10 points" do
        pg = PointGenerator.new(lambda { |x| 2*x })

        points = pg.generate(10, 0..9)

        points.length.should == 10

        points.each_with_index {|p, i| p.x.should == i; p.y.should == 2*p.x}
    end

    it "generates points from number in lits" do
        pg = PointGenerator.new(20)

        points = pg.generate(6, 0..5)

        points[0].y.should == 0
        points[1].y.should == 209
        points[2].y.should == 0
        points[3].y.should == 209
        points[4].y.should == 0
        points[5].y.should == 0
    end
end
