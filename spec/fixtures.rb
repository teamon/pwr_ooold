def load_fixtures!
  include DataMapper::Sweatshop::Unique
  DataMapper.auto_migrate!
  
  @skp = Faculty.create(:id => 0, :name => 'Studium Ksztacenia Podstawowego')
  @w1 = Faculty.create(:id => 1, :name => 'Architektura')
  @w2 = Faculty.create(:id => 2, :name => 'Budownictwo')
  @w3 = Faculty.create(:id => 3, :name => 'Chemiczny')
  @w4 = Faculty.create(:id => 4, :name => 'Elektronika')
  @w5 = Faculty.create(:id => 5, :name => 'Elektryczny')
  @w6 = Faculty.create(:id => 6, :name => 'Geoinżynieria, Górnictwo i Geologia')
  @w7 = Faculty.create(:id => 7, :name => 'Inżynieria rodowiska')
  @w8 = Faculty.create(:id => 8, :name => 'Informatyka i Zarządzanie')
  @w9 = Faculty.create(:id => 9, :name => 'Mechaniczno Energetyczny')
  @w10 = Faculty.create(:id => 10, :name => 'Mechaniczny')
  @w11 = Faculty.create(:id => 11, :name => 'Podstawowych Problemów Techniki')
  @w12 = Faculty.create(:id => 12, :name => 'Elektroniki Mikrosystemów i Fotoniki')
  
  @teamon = User.create(:login => "teamon", :email => "i@teamon.eu", :name => "Tymon Tobolski", 
      :password => "mapex", :password_confirmation => "mapex", :faculty => @w4, :year => 1)  
  
  # User.fix {{
  #   :name => /\w+ \w+/.gen,
  #   :email => unique {|i| "#{/\w+/.gen}@example.com" },
  #   :password => (password = /\w+/.gen),
  #   :password_confirmation => password
  # }}
end