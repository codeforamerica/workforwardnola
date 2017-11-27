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
    
    create_table(:schema_info) do
      Integer :version, :default=>0, :null=>false
    end
    
    create_table(:schema_seeds) do
      String :filename, :text=>true, :null=>false
      
      primary_key [:filename]
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
