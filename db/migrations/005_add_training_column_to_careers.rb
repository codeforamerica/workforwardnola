Sequel.migration do
  change do
    alter_table(:careers) do
      add_column :training, String, text: true
      add_column :experienced_range, String, text: true
      add_column :general_duties, String, text: true
      add_column :entry_wage, String, text: true
      drop_column :experienced_wage
    end
  end
end
