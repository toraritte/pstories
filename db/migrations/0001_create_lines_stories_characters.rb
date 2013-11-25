Sequel.migration do
  change do 

    create_table :lines do
      primary_key :id
      String :dialogue_item, text: true
      String :plot_item, text: true
      Integer :character_id
      Integer :story_id
      Float :sequence
    end

    create_table :stories do
      primary_key :id
      String :title
    end

    create_table :characters do
      primary_key :id
      String :name
    end
  end
end
