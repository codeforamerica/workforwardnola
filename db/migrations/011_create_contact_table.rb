Sequel.migration do
  change do

    create_table(:contact) do
      primary_key :id
      String :fname, null: false
      String :lname, null: false
      String :referral, null: false
      String :neighborhood, null: false
      String :best_way, null: false
      TrueClass :young_adult, null: false, default: false
      TrueClass :veteran, null: false, default: false
      TrueClass :no_transportation, null: false, default: false
      TrueClass :homeless, null: false, default: false
      TrueClass :no_drivers_license, null: false, default: false
      TrueClass :no_state_id, null: false, default: false
      TrueClass :disabled, default: false
      TrueClass :childcare, default: false
      TrueClass :criminal, default: false
      TrueClass :previously_incarcerated, default: false
      TrueClass :using_drugs, default: false
      TrueClass :none, default: false
    end

 

end
end