require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe User do
  
  VALID_PROPERTIES = {
    :login => 'teamon',
    :email => 'i@teamon.eu',
    :password => 'mapex',
    :password_confirmation => 'mapex',
    :year => 1
  }

  before do
    User.auto_migrate!
    
    @teamon = User.create(VALID_PROPERTIES)

  end
  
  it "should be valid" do
    @teamon.should be_valid
  end

  it "should not be valid without login" do
    @teamon.login = ""
    @teamon.should_not be_valid
    @teamon.errors.on(:login).should_not be_empty
  end
  
  it "should require unique login" do
    ivyl = User.new(VALID_PROPERTIES.merge(:email => "ivyl@teamon.eu"))
    ivyl.should_not be_valid
    ivyl.errors.on(:login).should_not be_empty
    
    ivyl.login = "ivyl"
    ivyl.should be_valid 
  end
  
  
  it "should accept only letters for name" do
    @teamon.name = "The Amon *"
    @teamon.should_not be_valid
    @teamon.errors.on(:name).should_not be_empty

    @teamon.name = "The Amon @<blah>"
    @teamon.should_not be_valid
    @teamon.errors.on(:name).should_not be_empty

    @teamon.name = "The Amon"
    @teamon.should be_valid
    @teamon.errors.on(:name).should be_nil
  end
  
  it "should accept only letters, numbers and -, _ for login" do
    @teamon.login = "The Amon *"
    @teamon.should_not be_valid

    @teamon.login = "The Amon @<blah>"
    @teamon.should_not be_valid

    @teamon.login = "teamon"
    @teamon.should be_valid
    
    @teamon.login = "teamo0n"
    @teamon.should be_valid
    
    @teamon.login = "teamo 0n"
    @teamon.should_not be_valid
    
    @teamon.login = "teamo_n"
    @teamon.should be_valid
    
    @teamon.login = "teamo-n"
    @teamon.should be_valid
  end
  
  it "should require 3..20 characters login" do
    @teamon.login = "a"
    @teamon.should_not be_valid
    @teamon.login = "ab"
    @teamon.should_not be_valid
    @teamon.login = "abqwerqwerqwerqwerqww"
    @teamon.should_not be_valid
  end
  
  it "should not be valid without email" do
    @teamon.email = ""
    @teamon.should_not be_valid
    @teamon.errors.on(:email).should_not be_empty
  end
  
  it "should require unique email" do
    ivyl = User.new(VALID_PROPERTIES.merge(:login => "ivyl"))
    ivyl.should_not be_valid
    ivyl.errors.on(:email).should_not be_empty
    
    ivyl.email = "ivyl@teamon.eu"
    ivyl.should be_valid 
  end
  
  it "should have :admin flag" do
    @teamon.admin?.should == false
    @teamon.admin = true
    @teamon.admin?.should == true
  end
  
  it "should require faculty" do
    pending
    @teamon.should respond_to(:faculty)
  end
  
  it "should have year property" do
    @teamon.should respond_to(:year)
  end
  
  it "should have accept year from 1..5" do
    @teamon.year = 0
    @teamon.should_not be_valid
    @teamon.year = 1
    @teamon.should be_valid
    @teamon.year = 5
    @teamon.should be_valid
    @teamon.year = 6
    @teamon.should_not be_valid
  end

end