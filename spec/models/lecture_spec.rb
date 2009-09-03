require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Lecture do

  before do
    load_fixtures!
    Lecture.auto_migrate!
    @lecture = Lecture.create(:date => DateTime.now, :name => "Programming", :user => @teamon, :faculty => @w4)
  end
  
  it "should be valid" do
    @lecture.should be_valid
  end
  
  it "should not be valid without name" do
    @lecture.name = ""
    @lecture.should_not be_valid
    @lecture.errors.on(:name).should_not be_empty
  end
  
  it "should require user" do
    @lecture.user = nil
    @lecture.should_not be_valid
    @lecture.errors.on(:user).should_not be_empty
  end
  
  it "should require faculty" do
    @lecture.faculty = nil
    @lecture.should_not be_valid
    @lecture.errors.on(:faculty).should_not be_empty
  end

end