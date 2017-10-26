Sequel.migration do
  up do
    alter_table(:careers) do
      drop_column :training_money_available
      drop_column :average_wage
      drop_column :experienced_wage

    end
  end

  down do
    alter_table(:careers) do
      add_column :training_money_available, TrueClass, null: false, default: false
      add_column :average_wage, Float, null: false, default: 0.0
    end
  end
end
