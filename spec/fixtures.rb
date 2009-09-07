def load_fixtures!
  include DataMapper::Sweatshop::Unique
  DataMapper.auto_migrate!
  
  @skp = Faculty.create(:code => "SKP", :name => 'Studium Ksztacenia Podstawowego')
  @w1 = Faculty.create(:code => "W1", :name => 'Architektura')
  @w2 = Faculty.create(:code => "W2", :name => 'Budownictwo')
  @w3 = Faculty.create(:code => "W3", :name => 'Chemiczny')
  @w4 = Faculty.create(:code => "W4", :name => 'Elektronika')
  @w5 = Faculty.create(:code => "W5", :name => 'Elektryczny')
  @w6 = Faculty.create(:code => "W6", :name => 'Geoinżynieria, Górnictwo i Geologia')
  @w7 = Faculty.create(:code => "W7", :name => 'Inżynieria rodowiska')
  @w8 = Faculty.create(:code => "W8", :name => 'Informatyka i Zarządzanie')
  @w9 = Faculty.create(:code => "W9", :name => 'Mechaniczno Energetyczny')
  @w10 = Faculty.create(:code => "W10", :name => 'Mechaniczny')
  @w11 = Faculty.create(:code => "W11", :name => 'Podstawowych Problemów Techniki')
  @w12 = Faculty.create(:code => "W12", :name => 'Elektroniki Mikrosystemów i Fotoniki')
  
  @teamon = User.create(:login => "teamon", :email => "i@teamon.eu", :name => "Tymon Tobolski", 
      :password => "mapex", :password_confirmation => "mapex", :faculty => @w4, :year => 1) 
      
  Lecture.fix {{
    :name => /[:sentence:]/.gen[0..49],
    :date => Time.now + rand(100).hours,
    :lecturer_name => [/\w+/.gen.capitalize, /\w+/.gen.capitalize].join(" "),
    :user => @teamon,
    :faculty => Faculty.all[rand(13)],
    :description => /[:sentence:]+/.gen
  }}
  
  50.times { Lecture.gen }
  
  # User.fix {{
  #   :name => /\w+ \w+/.gen,
  #   :email => unique {|i| "#{/\w+/.gen}@example.com" },
  #   :password => (password = /\w+/.gen),
  #   :password_confirmation => password
  # }}
end