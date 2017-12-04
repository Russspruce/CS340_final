/*
 * Drop statements to clean database records of old tables
 * if they exist.
*/

DROP TABLE IF EXISTS 'character';
DROP TABLE IF EXISTS 'nations';
DROP TABLE IF EXISTS 'series';
DROP TABLE IF EXISTS 'combats';
DROP TABLE IF EXISTS 'character_combats';


/*
 * Character Table
 * The characters of Avatar that will be created
*/

CREATE TABLE 'character' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'name' varchar(255) NOT NULL,
  'alignment' varchar(255) NOT NULL,
  'nation' int(11) DEFAULT NULL,
  'combat' int(11) DEFAULT NULL,
PRIMARY KEY ('id'),
UNIQUE KEY 'name' ('name'),
UNIQUE KEY 'alignment' ('alignment'),
KEY 'nation' ('nation'),
KEY 'era' ('era'),
CONSTRAINT 'character_ibfk_1' FOREIGN KEY ('nation') REFERENCES 'nations' ('id') ON DELETE
SET NULL ON UPDATE CASCADE,
CONSTRAINT 'character_ibfk_2' FOREIGN KEY ('era') REFERENCES 'series' ('id') ON
DELETE SET NULL ON UPDATE CASCADE
) ENGINE=’innoDB’;

/*
 * Nations table
 * The different nations in the world of the Avatar series
*/

CREATE TABLE 'nations' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'name' varchar(255) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'name' ('name')
) ENGINE=’innoDB’;

/*
 * Combats Table
 * A table that lists all the different forms of bending in
 * the world of Avatar.
*/


CREATE TABLE 'combats' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'bending' varchar(255) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'bending' ('bending')
) ENGINE=’innoDB’;

/*
 * Eras Table
 * A table that lists the two series that separate the different
 * groups of characters between each series.
*/

CREATE TABLE 'series' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'title' varchar(255) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'title' ('title')
) ENGINE=’innoDB’;


/*
 * Character_Combats Table
 * This table relates each character with what
 * bending arts they are capable of performing.
*/

CREATE TABLE 'character_combats' (
   'character_id' INT(11),
   'combat_id' INT(11),
   PRIMARY KEY ('character_id', 'combat_id'),
   FOREIGN KEY ('character_id') REFERENCES character('id')
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY ('combat_id') REFERENCES combats('id')
      ON DELETE CASCADE
      ON UPDATE CASCADE
) ENGINE=’innoDB’;
