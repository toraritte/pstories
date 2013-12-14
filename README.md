__A simple rails 4 app to create stories (especially) with dialogues__

It has many flaws and missing a lot therefore without further ado:

### Design
* DRY up code in views (TODO[2] and [3]) or reduce logic in views (plot, dialogue)
* adjust form text areas to an adequate size
* put 'Edit' to somewhere else  
  Looks like everyone's name is the hungarian first name and as p so lovingly
  put it: gay
* make existing characters selectable
  (tab completion, drop-down list)
* make the most recent line shown and don't let it run out of the screen
* make the `<table>`s disappear in views (TODO[1])
* use `respond_to` instead of simple `redirect_to`
* plot vs dialogue (put a separate text window for plot)
* characters with the same name
  - allow referencing chars in other stories or
  - make sure to distinguish them if only the name matches
  - (story.title can act as a namespace, story.title:character.name)

### Bugs
* extra page refresh needed in some cases for forms but not always

### DB, model, schema
* __PLOT ITEM ISSUE__
  0. Current status:
    - LINE simplified(mig:0004)
    - dialogue_item + plot_item => line_item
    - *effect*: plot-dialogue distinguished by character_id (plot?, plot obsolete)
  1. Enforce constraints on columns depending on each other? (... and how?)  
        <pre>
            plot_item     | "blabla" | null
            dialogue_item | NULL     | "blabla"
            character_id  | NULL     | 27
        </pre>
  2. Alter schema? (presuming the current one isn't the best solution)
        <pre>
            PLOT                            DIALOGUE
            id              STORY           id
            story_id -----> id <----------- story_id
            line_item       title           line_item
            sequence        total_lines     sequence          CHARACTER
                                            character_id ---> id
                                                              name

            STORY.total_lines keeps track of line number in a story and
            used to increment (PLOT|DIALOGUE).sequence in a consistent
            manner. ( seq method in STORY )
        </pre>

### Miscellaneous
* Authentication
  - a story can only be modified by the creator or the collaborator(s)
  - how to enable users to give permission for someone else?
  - how to visualize the differences in the text? (who did what)
* Input-in-a-bundle
  - input in plain text, parse to save it to DB
  - syntax: markdown?

### rake notes
  <pre>
    app/controllers/lines_controller.rb
    28:    # TODO[8] - not checking capitalization errors
    34:    # TODO[7] - once TODO[6] returns an object this whole mess can be made safe

    app/views/lines/edit.html.slim
    1:/ TODO[1] - find a better way then <table> in all the views
    4:    / TODO[2] - needs to be DRYed (render the page only according to @line.character_id,
    5:      TODO[2] -   without cluttering the view with code

    app/views/lines/index.html.slim
    1:/ TODO[2&3] - 3rd location where layout depends on line type (plot, dialogue)
    2:/ TODO[2&3] - _plot partial?
    7:  / TODO[6] - where to start...
    8:  / TODO[6] -(a) reorganize form so that it actually returns a line object in params
    9:  / TODO[6] -    (see params for stories#create)

    app/models/story.rb
    1:# TODO[9] - DB mess, see "git log --format=%B -n 1 c3c3086"
    2:# TODO[9] - couple examples: STORY[:id].add_character -> merrily saves duplicates
    3:# TODO[9] - UPDATE: this is intentional. use story.title (or .id) as a namespace

    config/routes.rb
    1:# TODO[4] - clean up routes

    spec/model/line_spec.rb
    18:  # TODO - write an "errors_on" helper (see story_spec.rb)
  </pre>
