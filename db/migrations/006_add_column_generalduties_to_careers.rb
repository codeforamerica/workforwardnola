Sequel.migration do
  change do
    alter_table(:careers) do
      add_column :general_duties, String, text: true
    end
  end
end
