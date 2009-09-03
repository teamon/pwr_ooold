require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Faculty do

  before do
    Faculty.auto_migrate!
    @w4 = Faculty.create(:code => "W4", :name => "Electronics")
  end
  
  it "should be valid" do
    @w4.should be_valid
  end

  it "should not be valid without code" do
    @w4.code = ""
    @w4.should_not be_valid
    @w4.errors.on(:code).should_not be_empty
  end
  
  it "should not be valid without name" do
    @w4.name = ""
    @w4.should_not be_valid
    @w4.errors.on(:name).should_not be_empty
  end
  
  it "should require unique code" do
    w3 = Faculty.new(:code => "W4", :name => "Chemistry")
    w3.should_not be_valid
    w3.errors.on(:code).should_not be_empty
    
    w3.code = "W5"
    w3.should be_valid 
  end
  
  it "should list in order by code" do
    w3 = Faculty.create(:code => "W3", :name => "Chemistry")
    w8 = Faculty.create(:code => "W8", :name => "Mechanics")
    
    Faculty.by_code.should == [w3, @w4, w8]
  end

end