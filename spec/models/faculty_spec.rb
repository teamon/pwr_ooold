require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Faculty do

  before do
    Faculty.auto_migrate!
    @w4 = Faculty.create(:id => 4, :name => "Electronics")
  end
  
  it "should be valid" do
    @w4.should be_valid
  end
  
  it "should not be valid without name" do
    @w4.name = ""
    @w4.should_not be_valid
    @w4.errors.on(:name).should_not be_empty
  end
  
  it "should have #full_name" do
    @w4.full_name.should == "W4 Electronics"
  end

end