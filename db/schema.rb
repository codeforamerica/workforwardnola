Sequel.migration do
  change do
    create_table(:careers) do
      primary_key :id
      String :name, :text=>true, :null=>false
      String :sector, :text=>true, :null=>false
      String :description, :text=>true
      TrueClass :certification_required, :default=>false, :null=>false
      String :training, :text=>true
      String :general_duties, :text=>true
      String :experienced_range, :text=>true
      String :entry_wage, :text=>true
      String :career_image, :text=>true
      String :alt_title, :text=>true
    end
    
    create_table(:contact) do
      primary_key :id
      String :first_name, :text=>true, :null=>false
      String :last_name, :text=>true, :null=>false
      String :referral, :text=>true, :null=>false
      String :neighborhood, :text=>true, :null=>false
      String :best_way, :text=>true, :null=>false
      TrueClass :young_adult, :default=>false, :null=>false
      TrueClass :veteran, :default=>false, :null=>false
      TrueClass :no_transportation, :default=>false, :null=>false
      TrueClass :homeless, :default=>false, :null=>false
      TrueClass :no_drivers_license, :default=>false, :null=>false
      TrueClass :no_state_id, :default=>false, :null=>false
      TrueClass :disabled, :default=>false
      TrueClass :childcare, :default=>false
      TrueClass :criminal, :default=>false
      TrueClass :previously_incarcerated, :default=>false
      TrueClass :using_drugs, :default=>false
      TrueClass :none, :default=>false
    end
    
    create_table(:oppcenters) do
      primary_key :id
      String :tca_name, :text=>true, :null=>false
      String :tca_address, :text=>true, :null=>false
      String :tca_phone, :text=>true, :null=>false
      String :tca_email, :text=>true, :null=>false
      String :goodwill_name, :text=>true, :null=>false
      String :goodwill_address, :text=>true, :null=>false
      String :goodwill_phone, :text=>true, :null=>false
      String :goodwill_email, :text=>true, :null=>false
      String :job1_name, :text=>true, :null=>false
      String :job1_address, :text=>true, :null=>false
      String :job1_phone, :text=>true, :null=>false
      String :job1_email, :text=>true, :null=>false
    end
    
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
    
    create_table(:traits) do
      primary_key :id
      String :name, :text=>true, :null=>false
      Integer :spreadsheet_key
    end
    
    create_table(:careers_traits, :ignore_index_errors=>true) do
      foreign_key :career_id, :careers, :null=>false, :key=>[:id]
      foreign_key :trait_id, :traits, :null=>false, :key=>[:id]
      
      primary_key [:career_id, :trait_id]
      
      index [:trait_id, :career_id]
    end
  end
end
