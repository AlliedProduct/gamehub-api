                                          Table "public.library_items"
   Column   |              Type              | Collation | Nullable |                  Default                  
------------+--------------------------------+-----------+----------+-------------------------------------------
 id         | bigint                         |           | not null | nextval('library_items_id_seq'::regclass)
 user_id    | bigint                         |           | not null | 
 game_id    | bigint                         |           | not null | 
 status     | character varying              |           |          | 
 rating     | integer                        |           |          | 
 notes      | text                           |           |          | 
 created_at | timestamp(6) without time zone |           | not null | 
 updated_at | timestamp(6) without time zone |           | not null | 
Indexes:
    "library_items_pkey" PRIMARY KEY, btree (id)
    "index_library_items_on_game_id" btree (game_id)
    "index_library_items_on_user_id" btree (user_id)
    "index_library_items_on_user_id_and_game_id" UNIQUE, btree (user_id, game_id)
Foreign-key constraints:
    "fk_rails_218f14633a" FOREIGN KEY (user_id) REFERENCES users(id)
    "fk_rails_4809258dbc" FOREIGN KEY (game_id) REFERENCES games(id)

