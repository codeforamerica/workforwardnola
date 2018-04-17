Sequel.migration do
  change do
    alter_table (:opp_centers) do
      add_column :contact, String, null: false
    end
  end
end
