Sequel.migration do
  change do
    create_table(:traits) do
      primary_key :id
      String :name, null: false
    end

    create_table(:careers) do
      primary_key :id
      String :name, null: false
      String :sector, null: false
      String :description, text: true
      Float :median_wage, null: false
    end

    create_join_table(career_id: :careers, trait_id: :traits)
  end

end
