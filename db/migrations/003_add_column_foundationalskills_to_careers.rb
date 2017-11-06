Sequel.migration do
  change do
    alter_table(:careers) do
      add_column :foundational_skills, String, text: trueg
    end
  end
end
