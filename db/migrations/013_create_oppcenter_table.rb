Sequel.migration do
  change do
    create_table :opp_centers do
      primary_key :id
      String :center, null: false
      String :name, null: false
      String :address, null: false
      String :phone, null: false
      String :email, null: false
    end
  end
end
