Sequel.migration do
  change do
    create_table (:contacts) do
      primary_key :id
      String :first_name, null: false
      String :last_name, null: false
      String :referral, null: false
      String :neighborhood, null: false
      String :best_way, null: false
      String :email_submission, null: false
      String :text_submission, null: false
      String :phone_submission, null: false
      TrueClass :young_adult, blank: false
      TrueClass :veteran, blank: false
      TrueClass :no_transportation, blank: false
      TrueClass :homeless, blank: false
      TrueClass :no_drivers_license, blank: false
      TrueClass :no_state_id, blank: false
      TrueClass :disabled, blank: false
      TrueClass :childcare, blank: false
      TrueClass :criminal, blank: false
      TrueClass :previously_incarcerated, blank: false
      TrueClass :using_drugs, blank: false
      TrueClass :none_of_above, blank: false
    end
  end
end
