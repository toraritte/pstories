Sequel::migration do
  up do
    alter_table :stories do
      add_unique_constraint :title
    end

    alter_table :lines do
      add_unique_constraint :sequence
    end
  end

  down do
    alter_table :stories do
      drop_constraint :stories_title_key
    end

    alter_table :lines do
      drop_constraint :lines_sequence_key
    end
  end
end
