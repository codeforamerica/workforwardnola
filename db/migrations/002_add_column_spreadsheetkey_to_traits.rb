Sequel.migration do 
  change do
    alter_table(:traits) do
      add_column :spreadsheet_key, Integer
    end
  end
end