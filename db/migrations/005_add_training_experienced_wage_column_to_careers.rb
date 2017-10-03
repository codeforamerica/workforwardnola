Sequel.migration do
  change do
    alter_table(:careers) do
      add_column :training, String, text: true
      add_column :experienced_wage, String, text: true
    end
  end
end
