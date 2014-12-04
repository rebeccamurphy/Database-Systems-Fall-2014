CREATE TYPE GENDER AS ENUM ('Female', 'Male', 'Other');
CREATE TABLE IF NOT EXISTS Comedians (
	 CID		 	 CHAR(8)	 	 NOT NULL,
	 Name		 	 TEXT		 	 NOT NULL,
	 DOB	 	 	 DATE			 NOT NULL,
	 Gender		 	 GENDER		 	 NOT NULL,
	 Nationality	 TEXT			 NOT NULL,
	 Alive			 BOOL			 NOT NULL,
	 YearFirstActive INT			 NOT NULL,
	 YearLastActive	 INT			 	     ,
	 PRIMARY KEY (CID)
);
INSERT INTO Comedians
VALUES 
('C0000001', 'Eddie Izzard', date '2/7/1962', 'Male', 'British', TRUE, 1982, NULL ),
('C0000002', 'Graham Chapman', date '1/8/1941', 'Male', 'British', FALSE, 1960, 1989),
('C0000003', 'Terry Gilliam', date '11/22/1940', 'Male', 'British', TRUE, 1967, NULL ),
('C0000004', 'Terry Jones', date '2/1/1942', 'Male', 'British', TRUE, 1969, NULL ),
('C0000005', 'John Cleese', date '10/27/1939', 'Male', 'British', TRUE, 1961, NULL ),
('C0000006', 'Michael Palin', date '5/5/1943', 'Male', 'British', TRUE, 1966, NULL ),
('C0000007', 'Kate Micucci', date '3/31/1980', 'Female', 'American', TRUE, 2001, NULL ),
('C0000008', 'Riki Lindhome', date '3/5/1979', 'Female', 'American', TRUE, 2001, NULL ),
('C0000009', 'Dara Ó Briain', date '2/4/1972', 'Male', 'Irish', TRUE, 1998, NULL ),
('C0000010', 'Dylan Moran', date '11/3/1971', 'Male', 'Irish', TRUE, 1992, NULL )
('C0000011', 'Julian Barratt', date '5/4/1968', 'Male', 'British', TRUE, 1995, NULL ),
('C0000012', 'Noel Fielding', date '5/21/1973', 'Male', 'British', TRUE, 1996, NULL );




CREATE TABLE IF NOT EXISTS Troupes (
	 TID		 	 CHAR(8)	 	 NOT NULL,
	 Name		 	 TEXT		 	 NOT NULL,
	 CountryOfOrigin TEXT			 NOT NULL,
	 YearCreated	 INT			 NOT NULL,
	 YearEnded		 INT			 	     ,
	 PRIMARY KEY (TID)
);
INSERT INTO Troupes
VALUES 
('T0000001', 'Monty Python', 'England', 1969, 1983),
('T0000002', 'Garfunkel and Oates', 'United States', 2007, NULL),
('T0000003', 'The Mighty Boosh', 'England', 1998, 2009);

CREATE TABLE IF NOT EXISTS BelongsTo (
	 CID		 	 CHAR(8)	 NOT NULL REFERENCES Comedians(CID),
	 TID		 	 CHAR(8)	 NOT NULL REFERENCES Troupes(TID)
);

INSERT INTO BelongsTo
VALUES 
('C0000002', 'T0000001'),
('C0000003', 'T0000001'),
('C0000004', 'T0000001'),
('C0000005', 'T0000001'),
('C0000006', 'T0000001'),
('C0000007', 'T0000002'),
('C0000008', 'T0000002'),
('C0000011', 'T0000003'),
('C0000012', 'T0000003');

CREATE TABLE IF NOT EXISTS Media (
	 MediaID	 	 CHAR(10)	 NOT NULL,
	 Name		 	 TEXT		 NOT NULL,
	 YearReleased 	 INT		 NOT NULL,
	 Genre		 	 TEXT		 NOT NULL,
	 CountryOfOrigin TEXT		 NOT NULL, 
	PRIMARY KEY (MediaID)
);
INSERT INTO Media
VALUES 
('Media00001', 'Monty Python and the Holy Grail', 1975, 'Comedy', 'United Kingdom'),
('Media00002', 'Monty Python’s Flying Circus',1969, 'Sketch Comedy', 'United Kingdom'),
('Media00003', 'All Over Your Face', 2011,  'Comedy', 'United States'),
('Media00004', 'Black Books', 2000, 'Sitcom', 'United Kingdom'),
('Media00005', 'This Is the Show', 2010, 'Stand Up Comedy', 'United Kingdom'),
('Media00006', 'Monty Pythons Big Red Book', 1971, 'Comedy', 'United Kingdom'),
('Media00007', 'The Boosh', 2001, 'Surreal Comedy', 'United Kingdom');

CREATE TABLE IF NOT EXISTS IsIn ( 
	 MediaID	 	 CHAR(10)	 NOT NULL REFERENCES Media(MediaID),
	 CID		 	 CHAR(8)	 NOT NULL REFERENCES Comedians(CID)
);
INSERT INTO IsIn values
('Media00001', 'C0000002'),
('Media00001', 'C0000003'),
('Media00001', 'C0000004'),
('Media00001', 'C0000005'),
('Media00001', 'C0000006'),

('Media00002', 'C0000002'),
('Media00002', 'C0000003'),
('Media00002', 'C0000004'),
('Media00002', 'C0000005'),
('Media00002', 'C0000006'),

('Media00003', 'C0000007'),
('Media00003', 'C0000008'),

('Media00004', 'C0000010'),

('Media00005', 'C0000009'),

('Media00006', 'C0000002'),
('Media00006', 'C0000003'),
('Media00006', 'C0000004'),
('Media00006', 'C0000005'),
('Media00006', 'C0000006'),

('Media00007', 'C0000011'),
('Media00007', 'C0000012');

CREATE TABLE IF NOT EXISTS Audio (
	 AudioID		 CHAR(8)	  NOT NULL,
	 MediaID	 	 CHAR(10)	  NOT NULL REFERENCES Media(MediaID),
	 PRIMARY KEY (AudioID)
);

INSERT INTO Audio VALUES
('Audio001', 'Media00003'),
('Audio002', 'Media00007');

CREATE TABLE IF NOT EXISTS RadioSeries (
	 RID		 	    		CHAR(5)	 NOT NULL,
	 AudioID	 	    		CHAR(8)	 NOT NULL REFERENCES Audio(AudioID),
	 YearEnded	 	    		INT		 NOT NULL,
	 NumSeasons	 	    		INT		 NOT NULL,
	 NumEpisodes 	    	    INT		 NOT NULL, 
	 AvgEpisodeLengthMin        INT	 	 NOT NULL, 
	 RadioStation		    	TEXT 	 NOT NULL,
	PRIMARY KEY (RID)
);

INSERT INTO RadioSeries VALUES 
('R0001', 'Audio002', 2001, 1, 6, 100, 'BBC');
CREATE TABLE IF NOT EXISTS Albums (
	 AID		 	CHAR(5)	  NOT NULL,
	 AudioID	 	CHAR(8)	  NOT NULL REFERENCES Audio(AudioID),
	 NumTracks		INT 	  NOT NULL,
	 LengthMins		INT 	  NOT NULL,
	 PRIMARY KEY (AID)
);
INSERT INTO Albums VALUES
('A0001', 'Audio001', 10, 25);


CREATE TABLE IF NOT EXISTS Visual (
	 VisualID	 	CHAR(9)	    NOT NULL,
	 MediaID	 	CHAR(10)    NOT NULL REFERENCES Media(MediaID),
	 PRIMARY KEY (VisualID)
);

INSERT INTO Visual VALUES
('Visual001', 'Media00006');


CREATE TABLE IF NOT EXISTS Books (
	 BID		 	CHAR(5)	    NOT NULL,
	 VisualID	 	CHAR(9)	    NOT NULL REFERENCES Visual(VisualID),
	 PageCount		INT		    NOT NULL,
	 PRIMARY KEY (BID)
);

INSERT INTO Books VALUES
('B0001','Visual001', 64);

CREATE TABLE IF NOT EXISTS TVShows (
	 TVID		 		CHAR(5)	    NOT NULL,
	 AudioVisualID			CHAR(8)	    NOT NULL REFERENCES AudioVisual(AudioVisualID),
	 YearEnded			INT	    NOT NULL,
	 NumSeasons			INT	    NOT NULL,
	 NumEpisodes			INT	    NOT NULL,
	 EpisodeLengthMins		INT	    NOT NULL, 
	 TVStation			TEXT	    NOT NULL,
	 PRIMARY KEY (TVID)
);
CREATE TABLE IF NOT EXISTS AudioVisual (
	 AudioVisualID 	CHAR(15)	    NOT NULL,
	 MediaID	CHAR(10)	    NOT NULL REFERENCES Media(MediaID),
	 PRIMARY KEY (AudioVisualID)
);

INSERT INTO AudioVisual VALUES
('AudioVisual0001','Media00001'),
('AudioVisual0002','Media00002'),
('AudioVisual0003','Media00004'),
('AudioVisual0004','Media00005');

CREATE TABLE IF NOT EXISTS TVShows (
 TVID		 		CHAR(5)	    NOT NULL,
 AudioVisualID		CHAR(8)	    NOT NULL REFERENCES AudioVisual(AudioVisualID),
 YearEnded			INT		    NOT NULL,
 NumSeasons			INT		    NOT NULL,
 NumEpisodes		INT		    NOT NULL,
 EpisodeLengthMins	INT		    NOT NULL, 
 TVStation			TEXT	    NOT NULL,
	 PRIMARY KEY (TVID)
);

INSERT INTO TVShows VALUES 
('TV0001', 'AudioVisual0002', 1974, 4, 45, 30, 'BBC1'),
('TV0002', 'AudioVisual0003', 2004, 3, 18, 25, 'Channel 4' );

CREATE TABLE IF NOT EXISTS Movies (
	 MID		 		CHAR(6)	    NOT NULL,
	 AudioVisualID		CHAR(15)    NOT NULL REFERENCES AudioVisual(AudioVisualID),
	 AvgReviewPercent	INT		    NOT NULL,
 	 LengthMins			INT		    NOT NULL,
	 PRIMARY KEY (MID)
);
INSERT INTO Movies VALUES 
('M0001', 'AudioVisual0001', 97, 91);

CREATE TABLE IF NOT EXISTS StandUpShows (
	 SUID		 				CHAR(6)	    NOT NULL,
	 AudioVisualID				CHAR(15)	NOT NULL REFERENCES AudioVisual(AudioVisualID),
	 LengthMins					INT		    NOT NULL,
	 City						TEXT	    NOT NULL,
	 Country 					TEXT		NOT NULL,
	 PRIMARY KEY (SUID)
);

INSERT INTO StandUpShows VALUES
('SU0001', 'AudioVisual0004', 102, 'London', 'England');