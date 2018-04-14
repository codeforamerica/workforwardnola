Sequel.migration do
  change do
    create_table (:oppcenters) do
      primary_key :id
      String :tca_name, null: false
      String :tca_address, null: false
      String :tca_phone, null: false
      String :tca_email, null: false
      String :goodwill_name, null: false
      String :goodwill_address, null: false
      String :goodwill_phone, null: false
      String :goodwill_email, null: false
      String :job1_name, null: false
      String :job1_address, null: false
      String :job1_phone, null: false
      String :job1_email, null: false
    end
  end
end
