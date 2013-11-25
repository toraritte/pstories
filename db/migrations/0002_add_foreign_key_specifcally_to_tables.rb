Sequel::migration do
  up do
    alter_table :lines do
      add_foreign_key [:story_id], :stories
      add_foreign_key [:character_id], :characters
    end

    create_table :characters_stories do
      foreign_key :character_id, :characters
      foreign_key :story_id, :stories
    end
  end

  down do
    alter_table :lines do
      drop_foreign_key [:story_id]
      drop_foreign_key [:character_id]
    end

    drop_table :characters_stories
  end
end

