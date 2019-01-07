Sequel.migration do
  change do
    alter_table(:careers) do
      add_column :career_image, String, text: true
      add_column :alt_title, String, text: true
    end
  end
end
