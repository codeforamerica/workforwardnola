Sequel.migration do
  change do
    alter_table(:careers) do
      add_column :entry_wage, String, text: true
    end
  end
end
