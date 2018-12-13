Sequel.migration do
  up do
    alter_table(:careers) do
      drop_column :experienced_wage
    end
  end

  down do
    alter_table(:careers) do
      add_column :experienced_wage, Float, null: false, default: 0.0
    end
  end
end
