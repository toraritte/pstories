Sequel::migration do
  up do
    alter_table :lines do
      rename_column :plot_item, :line_item
      drop_column   :dialogue_item
    end
  end

  down do
    alter_table :lines do
      rename_column :line_item, :plot_item
      add_column    :dialogue_item, String, :text=>true
    end
  end
end
