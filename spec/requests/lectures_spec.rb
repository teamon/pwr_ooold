require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a lecture exists" do
  Lecture.all.destroy!
  request(resource(:lectures), :method => "POST", 
    :params => { :lecture => { :id => nil }})
end

describe "resource(:lectures)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:lectures))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of lectures" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a lecture exists" do
    before(:each) do
      @response = request(resource(:lectures))
    end
    
    it "has a list of lectures" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Lecture.all.destroy!
      @response = request(resource(:lectures), :method => "POST", 
        :params => { :lecture => { :id => nil }})
    end
    
    it "redirects to resource(:lectures)" do
      @response.should redirect_to(resource(Lecture.first), :message => {:notice => "lecture was successfully created"})
    end
    
  end
end

describe "resource(@lecture)" do 
  describe "a successful DELETE", :given => "a lecture exists" do
     before(:each) do
       @response = request(resource(Lecture.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:lectures))
     end

   end
end

describe "resource(:lectures, :new)" do
  before(:each) do
    @response = request(resource(:lectures, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@lecture, :edit)", :given => "a lecture exists" do
  before(:each) do
    @response = request(resource(Lecture.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@lecture)", :given => "a lecture exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Lecture.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @lecture = Lecture.first
      @response = request(resource(@lecture), :method => "PUT", 
        :params => { :lecture => {:id => @lecture.id} })
    end
  
    it "redirect to the lecture show action" do
      @response.should redirect_to(resource(@lecture))
    end
  end
  
end

