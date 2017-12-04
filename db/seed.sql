/*
 * The information below is used to populate the tables created and to
 * have them filled with the populated information for the tables to
 * properly display the data.
*/

/*
 * Prepopulating the table character with information for each Avatar characters
*/

INSERT INTO character (id, name, alignment, nation, series) VALUES
(1, 'Aang', 'Good', 3, 1),
(2, 'Katara', 'Good', 1, 1),
(3, 'Sokka', 'Good', 1, 1),
(4, 'Toph', 'Good', 2, 1),
(5, 'Zuko', 'Good', 4, 1),
(6, 'Azula', 'Evil', 4, 1),
(7, 'Ozai', 'Evil', 4, 1),
(8, 'Korra', 'Good', 1, 2),
(9, 'Mako', 'Good', 5, 2),
(10, 'Bolin', 'Good', 5, 2),
(11, 'Asami', 'Good', 5, 2),
(12, 'Amon', 'Evil', 1, 2),
(13, 'Zaheer', 'Evil', 3, 2);


/*
 * Prepopulating the table Nations with the different nations in Avatar
*/

INSERT INTO nations (id, name) VALUES
(1, 'Water Tribe'),
(2, 'Earth Kingdom'),
(3, 'Air Nomads'),
(4, 'Fire Nation'),
(5, 'United Republic');


/*
 * Prepopulating the table Combats with different bending styles
*/

INSERT INTO combats (id, bending) VALUES
(1, 'Waterbending'),
(2, 'Earthbending'),
(3, 'Firebending'),
(4, 'Airbending'),
(5, 'Energybending'),
(6, 'Metalbending'),
(7, 'Bloodbending'),
(8, 'Lavabending'),
(9, 'Lightning'),
(10, 'Nonbender');

/*
 * Prepopulating the table series with the different series that were featured in
 * the world of Avatar
*/

INSERT INTO series (id, title) VALUES
(1, 'Last Airbender'),
(2, 'Legend of Korra');

/*
 * Prepopulating the table for character_combats
*/

INSERT INTO 'character_combats' VALUES
(1,1), (1,2), (1,3), (1,4), (1,5),
(2,1), (2,7),
(3,10),
(4,2), (4,6),
(5,3),
(6,3), (6,9),
(7,3), (7,9),
(8,1), (8,2), (8,3), (8,4), (8,5), (8,6),
(9,3), (9,9),
(10,2), (10,8),
(11,10),
(12,1), (12,7),
(13,4);
