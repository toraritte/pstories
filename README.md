__A simple rails 4 app to create stories (especially) with dialogues__

It has many flaws and missing a lot therefore without further ado:

### Design
* distinguish lines of different characters (and plot lines)
* adjust form text areas to an adequate size
* put 'Edit' to somewhere else 
  Looks like everyone's name is the hungarian first name and as p so lovingly
  put it: gay
* make existing characters selectable
  (tab completion, drop-down list)
* make the most recent line shown and don't let it run out of the screen
* make the `<table>`s disappear in views (TODO[1])

### Bugs
* extra page refresh needed in some cases for forms but not always

### DB, model, schema
* add constraints (postgres) AND validation (sequel)  
     <pre>LINE: sequence -> validates_unique, validates_presence
          CHAR: name     -> (as LINE)
          STORY: title   -> (as LINE)</pre>
* __PLOT ITEM ISSUE__
  1. Enforce constraints on columns depending on each other? (... and how?)  
        <pre>plot_item     | "blabla" | null
             dialogue_item | NULL     | "blabla"
             character_id  | NULL     | 27</pre>
  2. Alter schema? (presuming the current one isn't the best solution)
        PLOT                            DIALOGUE
        id              STORY           id
        story_id -----> id <----------- story_id
        plot_item       title           dialogue_item
        sequence                        sequence          CHARACTER
                                       character_id ---> id
                                                         name
        The lines of a story could be queried with a join and ordered by
        sequence but joins are expensive and could be that this idea is
        even more messed up.

### Miscellaneous
* Authentication
  - a story can only be modified by the creator or the collaborator(s)
  - how to enable users to give permission for someone else?
  - how to visualize the differences in the text? (who did what)
* Input-in-a-bundle
  - work out the a syntax for parsing a new dialogue in plain text

### rake notes
app/controllers/lines_controller.rb:
  * [25] [TODO] [8] - not checking capitalization errors
  * [27] [TODO] [7] - once TODO[6] returns an object this whole mess can be made safe
  * [28] [TODO] [8] - duplicate code everywhere

app/models/line.rb:
  * [ 5] [TODO] [5] - validation for line creation
  * [ 6] [TODO] [5] -   new dialogue? character needed (new or existing char?)

app/models/story.rb:
  * [ 1] [TODO] [9] - DB mess, see "git log --format=%B -n 1 c3c3086"

app/views/lines/edit.html.slim:
  * [ 4] [TODO] [2] - needs to be DRYed (see line 9)

app/views/lines/index.html.slim:
  * [ 1] [TODO] [2&3] - 3rd location where layout depends on line type (plot, dialogue)
  * [ 2] [TODO] [2&3] - _plot partial?
  * [ 7] [TODO] [6] - where to start...
  * [ 8] [TODO] [6] -(a) reorganize form so that it actually returns a line object in params
  * [ 9] [TODO] [6] -    (see params for stories#create)
  * [10] [TODO] [6] -(b) new model attributes? eg line_category = plot OR dialogue
  * [25] [TODO] [3] - ugly (both rendered page and code). Restructure?

config/environments/production.rb:
  * [80] [TODO] [9] - the 'Sequel::Model.db =' is probably totally unnecessary

config/routes.rb:
  * [ 1] [TODO] [4] - clean up routes

