Sequel.migration do
  change do
    alter_table(:careers) do
      add_column :experienced_range, String, text: true
    end
  end
end
