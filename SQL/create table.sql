-- SQLite
-- Create Table
CREATE TABLE main.chapter_type(
    chapter_type_id INTEGER PRIMARY KEY Autoincrement,
    chapter_type_name text NOT NULL
);

INSERT INTO chapter_type (chapter_type_id, chapter_type_name) values 
    (1, 'Archon'),
    (2, 'Story'),
    (3, 'Hangout'),
    (4, 'Event'),
    (5, 'Other'),
    (6, 'Character')
;

CREATE TABLE main.chapter(
    chapter_id INTEGER PRIMARY KEY Autoincrement,
    chapter_name text NOT NULL UNIQUE,
    chapter_type_id int NOT NULL,
    FOREIGN KEY (chapter_type_id)
    REFERENCES chapter_type (chapter_type_id)
);

CREATE TABLE main.quest(
    quest_id INTEGER PRIMARY KEY Autoincrement,
    quest_name text NOT NULL,
    chapter_id int NOT NULL,
    quest_link text NOT NULL UNIQUE,
    FOREIGN KEY (chapter_id)
    REFERENCES chapter (chapter_id)  
);

CREATE TABLE main.dialogue(
    dialogue_id INTEGER PRIMARY KEY Autoincrement,
    dialogue_text text NOT NULL,
    dialogue_quest_id int NOT NULL,
    dialogue_audio_url text NOT NULL UNIQUE,
    max_sentence_length int NOT NULL,   -- 最长单句单词数。用于判断长难句的存在。
    dialogue_audio_name text NOT NULL,
    word_frequency int,
    FOREIGN KEY (dialogue_quest_id)
    REFERENCES quest (quest_id)
);

-- create only event view
CREATE VIEW dialogue_only_events AS
SELECT *
FROM dialogue
WHERE dialogue_quest_id IN (
        SELECT quest_id
        FROM quest
        where chapter_id IN (
                SELECT chapter_id FROM chapter WHERE chapter_type_id <> 6
            )
    );


-- drop all tables
drop TABLE main.quest;
drop TABLE main.chapter;
drop TABLE main.dialogue;
drop TABLE main.chapter_type;
