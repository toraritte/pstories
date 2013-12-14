Sequel::migration do
  change do
    alter_table :characters do
      set_column_not_null :name
    end

    alter_table :stories do
      set_column_not_null :title
    end

    alter_table :lines do
      set_column_not_null :line_item
      set_column_default :character_id, nil
    end
  end
end
