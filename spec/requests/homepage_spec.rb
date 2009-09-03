require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "Homepage" do
  before(:each) do
    load_fixtures!
  end
  
  it "should list all faculties" do
    resp = visit "/"
    
    resp.should have_list(<<-LIST)
      SKP Studium Ksztacenia Podstawowego
      W1 Architektura
      W2 Budownictwo
      W3 Chemiczny
      W4 Elektronika
      W5 Elektryczny
      W6 Geoinżynieria, Górnictwo i Geologia
      W7 Inżynieria rodowiska
      W8 Informatyka i Zarządzanie
      W9 Mechaniczno Energetyczny
      W10 Mechaniczny
      W11 Podstawowych Problemów Techniki
      W12 Elektroniki Mikrosystemów i Fotoniki
    LIST
  end
  

end
