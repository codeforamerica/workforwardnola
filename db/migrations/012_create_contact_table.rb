Sequel.migration do
  change do


    create_table :contacts do

      primary_key :id
      String :first_name, null: false
      String :last_name, null: false
      String :referral, null: false
      String :neighborhood, null: false
      String :best_way, null: false
      String :email_submission, 
      String :phone_submission,
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
      TrueClass :none_of_above, default: false
    end
  end

end
