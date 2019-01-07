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
      Float :average_wage, null: false
      Float :experienced_wage, null: false
      TrueClass :training_money_available, null: false, default: false
      TrueClass :certification_required, null: false, default: false
    end

    create_join_table(career_id: :careers, trait_id: :traits)
  end
end
