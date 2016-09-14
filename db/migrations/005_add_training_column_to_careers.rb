Sequel.migration do
  change do
    alter_table(:careers) do
      add_column :training, String, text: true
    end
  end
end
