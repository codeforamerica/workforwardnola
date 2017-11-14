Sequel.migration do
  up do
    alter_table(:careers) do
      drop_column :foundational_skills
    end
  end

  down do
    alter_table(:careers) do
      add_column :foundational_skills, String, text: true
    end
  end
end