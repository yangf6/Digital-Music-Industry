/*select * from CUSTOMER_BUILD.[dbo].[CUSTOMERTRASH]
SELECT TOP 10* INTO CUSTOMER_TRASH
FROM CUSTOMER_BUILD.[dbo].[CUSTOMERTRASH]*/

SELECT * FROM CUSTOMER_Address
SELECT * FROM CUSTOMER_TRASH

DROP PROCEDURE addCustomer
DROP TABLE CUSTOMER_TRASH

CREATE PROCEDURE addCustomer
AS
DECLARE @ID int
DECLARE @City varchar (35)
DECLARE @State varchar(50)
DECLARE @Fname varchar(50)
DECLARE @Lname varchar(50)
DECLARE @zip varchar(50)
DECLARE @AddressID varchar(100)
BEGIN
SET @ID = (SELECT Min(CustomerID) FROM CUSTOMER_TRASH)
SET @AddressID = (SELECT CustomerAddress FROM CUSTOMER_TRASH WHERE CustomerID = @ID)
SET @City = (SELECT CustomerCity FROM CUSTOMER_TRASH WHERE CustomerID = @ID)
SET @State = (SELECT CustomerState FROM CUSTOMER_TRASH Where CustomerID = @ID)
SET @Fname = (SELECT CustomerFname FROM CUsTOMER_TRASH Where CustomerID = @ID)
SET @Lname = (SELECT CustomerLname FROM CUSTOMER_TRASH WHERE CustomerID = @ID)
SET @Zip =(SELECT CustomerZIP FROM CUSTOMER_TRASH WHERE CustomerID = @ID)

INSERT INTO CUSTOMER(CustomerID, CustFname, CustLname, CustAddress, CustCity, CustState, CustZip)
Values (@ID, @Fname, @Lname, @AddressID, @City, @State, @Zip)
DELETE FROM CUSTOMER_TRASH WHERE CustomerID = @ID
END

addCustomer
select * from [dbo].[Customer]
SET IDENTITY_INSERT [dbo].[Customer] ON
SET IDENTITY_INSERT [dbo].[Customer] OFF

/*DELETE FROM [dbo].[Customer]
WHERE CustomerID=10 */

SUBSCRIPTION TYPE
select * from  [dbo].[Subscription_Type]

INSERT INTO [dbo].[Subscription_Type](SubscriptionTypeID, SubscriptionTypeName, SubscriptionTypeDescr)
Values(1, "Premium", "They paid")

INSERT INTO [dbo].[Subscription_Type](SubscriptionTypeID, SubscriptionTypeName, SubscriptionTypeDescr)
Values(2, "Free", "They did not pay")

/*SET IDENTITY_INSERT [dbo].[Subscription_Type] OFF
SET IDENTITY_INSERT [dbo].[Subscription_Type] ON */



SUBSCRIPTION

SELECT * FROM [dbo].[Subscription]

CREATE PROCEDURE addSubscription
@Fname varchar(20),
@Lname varchar(20),
@SubTypeName varchar(20),
@Begin datetime,
@End datetime

AS 

BEGIN

DECLARE @CustID int
DECLARE @SubTypeID int

SET @CustID = (SELECT CustomerID FROM [dbo].[Customer] WHERE Customer.CustFname = @Fname AND Customer.CustLname = @Lname)
SET @SubTypeID = (SELECT SubscriptionTypeID FROM [dbo].[Subscription_Type] WHERE SubscriptionTypeName = @SubTypeName)

INSERT INTO [dbo].[Subscription](SubscriptionTypeID, CustomerID,BeginDate, EndDate)
VALUES (@subTypeID, @CustID, @Begin, @End)

END


EXECUTE addSubscription @Fname = "Annette", @Lname = "Mugica", @SubTypeName = "Free", @Begin = "01-02-2000", @End = "01-02-2002"
EXECUTE addSubscription @Fname = "Nettie", @Lname = "Ori", @SubTypeName = "Free", @Begin = "02-03-2001", @End = "03-03-2001"
EXECUTE addSubscription @Fname = "Leroy", @Lname = "Heaney", @SubTypeName = "Free", @Begin = "03-04-2002", @End = "03-04-2005"
EXECUTE addSubscription @Fname = "Debbi", @Lname = "Hasson", @SubTypeName = "Free", @Begin = "04-05-2003", @End = "03-12-2007"
EXECUTE addSubscription @Fname = "Jarred", @Lname = "Marentis", @SubTypeName = "Free", @Begin = "05-06-2004", @End = "05-15-2008"
EXECUTE addSubscription @Fname = "Malisa", @Lname = "Ansbro", @SubTypeName = "Premium", @Begin = "06-10-2010", @End = "10-10-2010"
EXECUTE addSubscription @Fname = "Julieann", @Lname = "Tippy", @SubTypeName = "Premium", @Begin = "07-11-2011", @End = "08-08-2012"
EXECUTE addSubscription @Fname = "Earlie", @Lname = "Eveleth", @SubTypeName = "Premium", @Begin = "08-12-2012", @End = NULL
EXECUTE addSubscription @Fname = "Delena", @Lname = "Dakins", @SubTypeName = "Premium", @Begin = "09-13-2013", @End = "12-14-2014"
EXECUTE addSubscription @Fname = "Delmer", @Lname = "Grunow", @SubTypeName = "Premium", @Begin = "10-14-2014", @End = NULL

SELECT * FROM [dbo].[Subscription] 

/* DELETE FROM [dbo].[Subscription]
WHERE SubScriptionID=10 */



Access Type
select * from [dbo].[Access_Type]

INSERT INTO [dbo].[Access_Type] (AccessTypeID, AccessTypeName, AccessTypeDescr)
Values(1, "Streaming", "Users accessed this through streaming")

INSERT INTO [dbo].[Access_Type] (AccessTypeID, AccessTypeName, AccessTypeDescr)
Values(2, "Download", "Users access this through downloading means")

/*SET IDENTITY_INSERT [dbo].[Access_Type] OFF
SET IDENTITY_INSERT [dbo].[Access_Type] ON */


Access 
CREATE PROCEDURE addAccess
@DownloadDate datetime,
@AccessTypeName varchar(50),
@CustomerID int,
@RecordingName varchar (50)

AS 

BEGIN

DECLARE @AccessTypeID int
DECLARE @SubID int
DECLARE @RecID int

SET @AccessTypeID = (SELECT AccessTypeID FROM [dbo].[Access_Type] WHERE AccessTypeName = @AccessTypeName)
SET @SubID = (SELECT SubscriptionID FROM [dbo].[Subscription] WHERE CustomerID = @CustomerID)
SET @RecID = (SELECT RecordingID FROM [dbo].[Recording] WHERE RecordingName = @RecordingName)

INSERT INTO [dbo].[Access](SubscriptionID, RecordingID, AccessTypeID, DownloadDate)
VALUES (@SubID, @RecID, @AccessTypeID, @DownloadDate)

END

EXECUTE addAccess @CustomerID = "1", @RecordingName = "SummerOriginal", @AccessTypeName = "Download", @DownloadDate = "02-01-2001"
EXECUTE addAccess @CustomerID = "2", @RecordingName = "SummerCover", @AccessTypeName = "Download", @DownloadDate = "03-01-2001"
EXECUTE addAccess @CustomerID = "3", @RecordingName = "SorryOriginal", @AccessTypeName = "Download", @DownloadDate = "03-04-2004"
EXECUTE addAccess @CustomerID = "4", @RecordingName = "SorryCover", @AccessTypeName = "Download", @DownloadDate = "03-04-2004"
EXECUTE addAccess @CustomerID = "5", @RecordingName = "DarkHorseOriginal", @AccessTypeName = "Download", @DownloadDate = "05-06-2005"
EXECUTE addAccess @CustomerID = "6", @RecordingName = "DarkHorseCover", @AccessTypeName = "Download", @DownloadDate = "10-08-2010"
EXECUTE addAccess @CustomerID = "7", @RecordingName = "RipideOriginal", @AccessTypeName = "Download", @DownloadDate = "06-06-2012"
EXECUTE addAccess @CustomerID = "8", @RecordingName = "RipideCover", @AccessTypeName = "Streaming", @DownloadDate = "08-14-2013"
EXECUTE addAccess @CustomerID = "9", @RecordingName = "MapOriginal", @AccessTypeName = "Streaming", @DownloadDate = "10-08-2014"
EXECUTE addAccess @CustomerID = "10", @RecordingName = "MapCover", @AccessTypeName = "Streaming", @DownloadDate = "11-11-2014"



Comment
CREATE PROCEDURE addComment
@ComBody, 
@ComName varchar(200),
@AFname varchar(20), 
@ALname varchar(20)
AS
BEGIN 
DECLARE @ARID
DECLARE @CTID
SET @ARID = (SELECT ArtistID FROM [dbo].[Artist] WHERE ArtistFname = @AFname AND ArtistLname = @ALname) 
SET @CTID = (SELECT CommentTypeID FROM [dbo].[Comment_Type] WHERE CommentTypeName = @ComName) 
INSERT INTO [dbo].[Comment](CommentBody, ArtistRecordingID, CommentTypeID) 
VALUES (@ComBody, @ComName, @ARID, @CTID) 
END

Comment_Type
select * from [dbo].[Comment_Type]

INSERT INTO [dbo].[Comment_Type] (CommentTypeID, CommentTypeName, CommentTypeDescr)
Values(1, "Good", "Describes a good comment")

INSERT INTO [dbo].[Comment_Type] (CommentTypeID, CommentTypeName, CommentTypeDescr)
Values(2, "Bad", "Describes a bad comment")

/*SET IDENTITY_INSERT [dbo].[Comment_Type] OFF 
SET IDENTITY_INSERT [dbo].[Comment_Type] ON */


Instrument_Type 
select * from [dbo].[Instrument_Type]

INSERT INTO [dbo].[Instrument_Type] (InstrumentTypeID, InstrumentTypeName, InstrumentTypeDescr)
Values(1, "Woodwind", "Instruments that make sound by vibrations in the air")

INSERT INTO [dbo].[Instrument_Type] (InstrumentTypeID, InstrumentTypeName, InstrumentTypeDescr)
Values(2, "String", "Instruments that make sound by vibrations through string")

INSERT INTO [dbo].[Instrument_Type] (InstrumentTypeID, InstrumentTypeName, InstrumentTypeDescr)
Values(3, "Brass", "Instruments that make sound by vibration of the lips")

/*SET IDENTITY_INSERT [dbo].[Instrument_Type] OFF 
SET IDENTITY_INSERT [dbo].[Instrument_Type] ON */


Instrument
SELECT * FROM [dbo].[Instrument]

CREATE PROCEDURE addInstrument
@InstrumentTypeName varchar(50),
@InstrumentName varchar(50)

AS 

BEGIN
DECLARE @InstrumentTID int

SET @InstrumentTID = (SELECT InstrumentTypeID FROM [dbo].[Instrument_Type] WHERE Instrument_Type.InstrumentTypeName = @InstrumentTypeName)

INSERT INTO [dbo].[Instrument](InstrumentName, InstrumentTypeID)
VALUES (@InstrumentName, @InstrumentTID)

END

EXECUTE addInstrument @InstrumentTypeName = "Brass", @InstrumentName = "Trumpet"
EXECUTE addInstrument @InstrumentTypeName = "Brass", @InstrumentName = "Tuba"
EXECUTE addInstrument @InstrumentTypeName = "Woodwind", @InstrumentName = "Sax"
EXECUTE addInstrument @InstrumentTypeName = "Woodwind", @InstrumentName = "Flute"
EXECUTE addInstrument @InstrumentTypeName = "Woodwind", @InstrumentName = "Piccolo"
EXECUTE addInstrument @InstrumentTypeName = "String", @InstrumentName = "Guitar"
EXECUTE addInstrument @InstrumentTypeName = "String", @InstrumentName = "Cello"
EXECUTE addInstrument @InstrumentTypeName = "String", @InstrumentName = "Octobass"
EXECUTE addInstrument @InstrumentTypeName = "String", @InstrumentName = "Violin"
EXECUTE addInstrument @InstrumentTypeName = "String", @InstrumentName = "Viola"

/* DELETE FROM [dbo].[Instrument]
WHERE InstrumentID=4 
DROP PROCEDURE addInstrument 

SET IDENTITY_INSERT [dbo].[Instrument] OFF
SET IDENTITY_INSERT [dbo].[Instrument] ON */



Ensemble 

CREATE PROCEDURE addEnsemble
@EnsName varchar(20),
@EnsBegin DateTime,
@EnsEnd DateTime
AS
BEGIN
        	INSERT INTO [dbo].[Ensemble](EnsembleName, EnsembleBeginDate, EnsembleEndDate)
        	VALUES (@EnsName, @EnsBegin, @EnsEnd)
END

EXECUTE addEnsemble @EnsName = “Fleetwood Mac“, @EnsBegin = “07-01-67“, @EnsEnd = “02-02-95“
EXECUTE addEnsemble @EnsName = "Destiny"s Child", @EnsBegin = "03-03-03", @EnsEnd = "04-04-04"
EXECUTE addEnsemble @EnsName = "One Direction, @EnsBegin = "05-05-05", @EnsEnd = "06-06-06"
EXECUTE addEnsemble @EnsName = "Yellow Claw", @EnsBegin = "07-07-07", @EnsEnd = NULL
EXECUTE addEnsemble @EnsName = "DBMS", @EnsBegin = "08-08-08", @EnsEnd = "09-09-09"
EXECUTE addEnsemble @EnsName = "Rolling Stones", @EnsBegin = "10-10-10", @EnsEnd = "12-12-12"
EXECUTE addEnsemble @EnsName = "MGMT", @EnsBegin = "11-11-11", @EnsEnd = NULL
EXECUTE addEnsemble @EnsName = "Dixie Chicks", @EnsBegin = "11-12-13", @EnsEnd = NULL
EXECUTE addEnsemble @EnsName = "The Strokes", @EnsBegin = "03-18-14", @EnsEnd = "05-31-14"
EXECUTE addEnsemble @EnsName = "No Doubt”, @EnsBegin = "09-08-07", @EnsEnd = "07-08-09"


Ensemble_Artist 
 
CREATE PROCEDURE Ens_Artist_Insert
@BeginDate DateTime,
@EndDate DateTime
AS
BEGIN
        	DECLARE @EnsID INT
	DECLARE @ArtID INT
        	SET @EnsID = IDENT_CURRENT('Ensemble')
        	SET @ArtID = IDENT_CURRENT('Artist')
        	INSERT INTO Ensemble_Artist(EnsembleID, ArtistID, BeginDate, EndDate)
			VALUES (@EnsID,@ArtID,@BeginDate,@EndDate)
END

The one not using ident
CREATE PROCEDURE Ens_Artist_Insert
@BeginDate DateTime,
@EndDate DateTime,
@Ensemble varchar(50),
@ArtistF varchar(50),
@ArtistL varchar(50)
AS
BEGIN
        	DECLARE @EnsID INT
			DECLARE @ArtID INT
        	SET @EnsID = (select EnsembleID from [dbo].[Ensemble] where EnsembleName = @Ensemble)
        	SET @ArtID = (select ArtistID from [dbo].[Artist] where ArtistFname = @ArtistF and ArtistLname = @ArtistL)
        	INSERT INTO Ensemble_Artist(EnsembleID, ArtistID, BeginDate, EndDate)
			VALUES (@EnsID,@ArtID,@BeginDate,@EndDate)
END


          

Artist
CREATE PROCEDURE addArtist
@Fname varchar(100),
@Lname varchar(100)
AS
BEGIN
        	INSERT INTO Artist(ArtistFname, ArtistLname)
        	VALUES (@Fname, @Lname)
END

EXECUTE addArtist @Fname = "Beyonce", @Lname = "Knowles"
EXECUTE addArtist @Fname = "Solange", @Lname = "Knowles"
EXECUTE addArtist @Fname = "Sam", @Lname = "Smith"
EXECUTE addArtist @Fname = "Mariah", @Lname = "Carey"
EXECUTE addArtist @Fname = "Ariana", @Lname = "Grande"
EXECUTE addArtist @Fname = "Kanye", @Lname = "West"
EXECUTE addArtist @Fname = "Katy", @Lname = "Perry"
EXECUTE addArtist @Fname = "Kendrick", @Lname = "Lamar"
EXECUTE addArtist @Fname = "Jay", @Lname = "Cole"
EXECUTE addArtist @Fname = "Pixie", @Lname = "Lott"

EXECUTE addArtist
@Fname = 'Todd',
@Lname =  'Larsen'

EXECUTE Ens_Artist_Insert
@BeginDate = '1980-08-19', @EndDate = '2014-09-23'





Song
CREATE PROCEDURE SONGUPDATE
@Song varchar(50)
AS
BEGIN
	INSERT INTO Song(Song)
	VALUES(@SongName)
END

EXECUTE SONGUPDATE
@SongName = "Summer"

1	Summer
2	Sorry
3	Dark Horse
4	Ripide
5	A Sky Full of Stars
6	What Do You Mean?
7	Sugar
8	Map
9	Counting Star
10	FourFiveSeconds


Genre
CREATE PROCEDURE GENREUPDATE
@GenName varchar(50),
@GenDes  varchar(200)
AS
BEGIN
	INSERT INTO Genre(GenreName,GenreDescr)
	VALUES(@GenName,@GenDes)
END

EXECUTE GENREUPDATE
@GenName = "Jazz",
@GenDes ="Music Style:Jazz"


select * from Genre

1	U.S TOP50	Music Ranked in U.S TOP 50
2	WORLD TOP50	Music Ranked in WORLD TOP 50
3	Happy Hoildays	Recoding use for specific hoilday season
4	Party	Recoding use for Party
5	Focus	Recoding use for helping you focus on what you are doing
6	Dinner	Recoding suitable for palying during dinner time
7	Country	Country style
8	POP	Music style:pop
9	Folk&Americana	Music style:Folk
10	Jazz	Music Style:Jazz


Mood
CREATE PROCEDURE MOODUPDATE
@MoodName varchar(50),
@MoodDes  varchar(200)
AS
BEGIN
	INSERT INTO Mood(MoodName,MoodDescr)
	VALUES(@MoodName,@MoodDes)
EN


1	Sad	feeling sad
2	Happy	Let the music light your day
3	Sleeping	Use the recording to help you fall sleep
4	Depression	Use the recording to boost your mood
5	Dizzy	Calm down with the peacful music
6	Chill out	
7	Coffee	
8	Coffee	Tbe music used in coffee house or coffee time
9	Energetic	Share the good mood with the music
10	Peaceful	




Label
CREATE PROCEDURE LABELUPDATE
@LNAME VARCHAR(50),
@ID INT
AS
DECLARE @City varchar (35)
DECLARE @State varchar(50)
DECLARE @zip varchar(50)
DECLARE @Address varchar (100)
BEGIN
SET @Address = (SELECT CustAddress FROM Customer WHERE CustomerID = @ID)
SET @City = (SELECT CustCity FROM Customer WHERE CustomerID = @ID)
SET @State = (SELECT CustState FROM Customer Where CustomerID = @ID)
SET @Zip =(SELECT CustZIP FROM Customer WHERE CustomerID = @ID)
SET IDENTITY_INSERT Label ON

INSERT INTO Label(LabelID,LabelName,LabelAddress,LabelCity,LabelState,LabelZip)
Values (@ID,@LNAME,@Address, @City, @State, @Zip)
END


LabelName	LabelAddress	LabeLCity	LabelState	LabelZipCode
Universal Music Group	14634 NW Interbay View Avenue	FLORALA	Alabama, AL	36442
 Sony BMG (Sony and BMG joint-venture)	5148 East Colorado Lake Way	PITTSBURGH	Pennsylvania, PA	15285
Warner Music Group	13706 South Maple Point Avenue	WALFORD	Iowa, IA	52351
 EMI	13808 S Maine Ridge Arterial	DEFIANCE	Pennsylvania, PA	16633
1965 Records	22102 East Garner Hill Way	NORTHFIELD	Massachusetts, MA	1360
1M1 Records	3607 SE Pierce Point Boulevard	SHARPSBURG	Georgia, GA	30277
1st & 15th Entertainment	11701 South Rainier Terrace Walk	APLINGTON	Iowa, IA	50604
2 Tone Records	9343 West Meyer Terrace Hillclimb	LYNN CENTER	Illinois, IL	61262
2.13.61	27322 West Eagle Point Drive	DONNELLY	Minnesota, MN	56235
20th Century Fox Records	16266 East Essex Bay Avenue	CUYAHOGA FALLS	Ohio, OH	44222




Studio

CREATE PROCEDURE STUDIOUPDATE
@StName varchar(50),
@StDes  varchar(200)
AS
BEGIN
	INSERT INTO Studio(StudioName,StudioDescr)
	VALUES(@StName,@StDes)
END

EXECUTE STUDIOUPDATE
@StName = 'Mirror Sound Studio',
@StDes ='Recording Stduio'

1	Studio X	Recording Studio
2	Empty Sea Studios	Recording Studio
3	Earwig Studio	Recording Studio
4	SophiaHat Studios	Recording Studio
5	Fastback Studios	Recording Studio
6	Orbit Audio	Recording Studio
7	Melody Music Studios	Music Instructor
8	Robert Lang Studios	Recording Studio
9	Electrokitty Recording Studio	Recording Studio
10	Mirror Sound Studio	Recording Studio




Position
select * from [dbo].[position]

INSERT INTO [dbo].[position] (RoleID, RoleName, RoleDescr)
Values(1, 'Singer', 'Sings the recordings')

INSERT INTO [dbo].[position] (RoleID, RoleName, RoleDescr)
Values(2, 'Manager', 'Manages the recording')

/*SET IDENTITY_INSERT [dbo].[position] OFF
SET IDENTITY_INSERT [dbo].[position] ON */


Album
SELECT * FROM [dbo].[Instrument]
SELECT * FROM [dbo].[Label]
SELECT * FROM [dbo].[Album]

CREATE PROCEDURE addAlbum
@LabelName varchar(100),
@AlbumName varchar(100),
@Releasedate datetime

AS 

BEGIN
DECLARE @LabID int

SET @LabID = (SELECT LabelID FROM [dbo].[Label] WHERE LabelName = @LabelName)

INSERT INTO [dbo].[Album](AlbumName, ReleaseDate, LabelD)
VALUES (@AlbumName, @Releasedate, @LabId)

END

EXECUTE addAlbum @AlbumName = "Beyonce", @Releasedate = "12-13-2013", @LabelName = "Universal Music Group"
EXECUTE addAlbum @AlbumName = "Abbey Road", @Releasedate = "10-01-1969", @LabelName = " Sony BMG (Sony and BMG joint-venture)"
EXECUTE addAlbum @AlbumName = "Teenage Dream", @Releasedate = "02-20-2010", @LabelName = " Warner Music Group"
EXECUTE addAlbum @AlbumName = "Hilary Duff", @Releasedate = "07-08-2008", @LabelName = "EMI"
EXECUTE addAlbum @AlbumName = "Metamorphosis", @Releasedate = "02-10-2002", @LabelName = "1965 Records"
EXECUTE addAlbum @AlbumName = "Double Fantasy", @Releasedate = "11-17-1980", @LabelName = "1M1 Records"
EXECUTE addAlbum @AlbumName = "Imagine", @Releasedate = "09-09-1971", @LabelName = "1st & 15th Entertainment"
EXECUTE addAlbum @AlbumName = "Night Visions", @Releasedate = "09-04-2012", @LabelName = "2 Tone Records"
EXECUTE addAlbum @AlbumName = "4", @Releasedate = "06-24-2011", @LabelName = "2.13.61"
EXECUTE addAlbum @AlbumName = "B'Day", @Releasedate = "09-04-2006", @LabelName = "20th Century Fox Records"


/* DELETE FROM [dbo].[Instrument]
WHERE InstrumentID=4 
DROP PROCEDURE addInstrument 

SET IDENTITY_INSERT [dbo].[Instrument] OFF
SET IDENTITY_INSERT [dbo].[Instrument] ON */


Album_Recording

GO
CREATE PROCEDURE addAlbRec
@AlbName varchar(20), 
@Rec varchar(40), 
@Sequence varchar(100), 
@AlbReleaseDate DateTime
AS
BEGIN
	DECLARE @AlbID INT
	DECLARE @RecID INT
	SET @AlbID = (SELECT AlbumID FROM [dbo].[Album] WHERE Album.AlbumName = @AlbName)
	SET @RecID = (SELECT RecordingID FROM [dbo].[Recording] WHERE Recording.RecordingName = @Rec)
	INSERT INTO [dbo].[Album_Recording](AlbumID, RecordingID, Sequence, ReleaseDate)
	VALUES (@AlbID, @RecID, @Sequence, @AlbReleaseDate) 
END 

EXECUTE addAlbRec @AlbName = "Prism", @Rec="SummerOriginal", @Sequence = "1st", @AlbReleaseDate = "12-13-13" 
EXECUTE addAlbRec @AlbName = "Prism", @Rec="SummerCover", @Sequence = "2nd", @AlbReleaseDate = "12-13-13" 
EXECUTE addAlbRec @AlbName = "Prism", @Rec="SorryOriginal", @Sequence = "3rd", @AlbReleaseDate = "12-13-13"
EXECUTE addAlbRec @AlbName = "Prism", @Rec="SorryCover", @Sequence = "4th", @AlbReleaseDate = "12-13-13"
EXECUTE addAlbRec @AlbName = "Prism", @Rec="DarkHorseOriginal", @Sequence = "5th", @AlbReleaseDate = "12-13-13" 
EXECUTE addAlbRec @AlbName = "Prism", @Rec="DarkHorseCover", @Sequence = "6th", @AlbReleaseDate = "12-13-13"  
EXECUTE addAlbRec @AlbName = "Prism", @Rec="RipideOriginal", @Sequence = "7th", @AlbReleaseDate = "12-13-13" 
EXECUTE addAlbRec @AlbName = "Prism", @Rec="RipideCover", @Sequence = "8th", @AlbReleaseDate = "12-13-13"
EXECUTE addAlbRec @AlbName = "Prism", @Rec="MapOriginal", @Sequence = "9th", @AlbReleaseDate = "12-13-13" 
EXECUTE addAlbRec @AlbName = "Prism", @Rec="MapCover", @Sequence = "Secret", @AlbReleaseDate = "12-13-13" 

Select * FROM Album_Recording




Recording 
GO 
CREATE PROCEDURE addRec
@RecName varchar(30), 
@RecDate DateTime,
@StudName varchar(20),
@SoName varchar(20),
@MoName varchar(20),
@GenName varchar(20),
@Len INT
AS 
BEGIN
	DECLARE @StudID INT
	DECLARE @SoID INT
	DECLARE @MoID INT
	DECLARE @GenID INT
	SET @StudID = (SELECT StudioID FROM [dbo].[Studio] WHERE Studio.StudioName = @StudName)
	SET @SoID = (SELECT SongID FROM [dbo].[Song] WHERE Song.SongName = @SoName)
	SET @MoID = (SELECT MoodID FROM [dbo].[Mood] WHERE Mood.MoodName = @MoName)
	SET @GenID = (SELECT GenreID FROM [dbo].[Genre] WHERE Genre.GenreName = @GenName)
	INSERT INTO [dbo].[Recording](RecordingName, RecordingDate, StudioID, SongID, MoodID, GenreID, Length) 
	VALUES (@RecName, @RecDate, @StudID, @SoID, @MoID, @GenID, @Len) 
END 

EXECUTE addRec @RecName = "SummerOriginal", @RecDate = "01-02-03", @StudName = "Studio X", @SoName = "Summer", @MoName = "Happy", @GenName = "POP", @Len = 3
EXECUTE addRec @RecName = "SummerCover", @RecDate = "01-02-03", @StudName = "Studio X", @SoName = "Summer", @MoName = "Happy", @GenName = "POP", @Len = 3
EXECUTE addRec @RecName = "SorryOriginal", @RecDate = "01-02-03", @StudName = "Studio X", @SoName = "Sorry", @MoName = "Sad", @GenName = "POP", @Len = 4
EXECUTE addRec @RecName = "SorryCover", @RecDate = "01-02-03", @StudName = "Studio X", @SoName = "Sorry", @MoName = "Sad", @GenName = "POP", @Len = 4
EXECUTE addRec @RecName = "DarkHorseOriginal", @RecDate = "01-02-03", @StudName = "Studio X", @SoName = "Dark Horse", @MoName = "Energetic", @GenName = "POP", @Len = 2
EXECUTE addRec @RecName = "DarkHorseCover", @RecDate = "01-02-03", @StudName = "Studio X", @SoName = "Dark Horse", @MoName = "Energetic", @GenName = "POP", @Len = 2
EXECUTE addRec @RecName = "RipideOriginal", @RecDate = "01-02-03", @StudName = "Studio X", @SoName = "Ripide", @MoName = "Sleeping", @GenName = "POP", @Len = 3
EXECUTE addRec @RecName = "RipideCover", @RecDate = "01-02-03", @StudName = "Studio X", @SoName = "Ripide", @MoName = "Sleeping", @GenName = "POP", @Len = 3
EXECUTE addRec @RecName = "MapOriginal", @RecDate = "01-02-03", @StudName = "Studio X", @SoName = "Map", @MoName = "Sleeping", @GenName = "POP", @Len = 5
EXECUTE addRec @RecName = "MapCover", @RecDate = "01-02-03", @StudName = "Studio X", @SoName = "Map", @MoName = "Sleeping", @GenName = "POP", @Len = 5

 

Artist_Recording
CREATE PROCEDURE addArtistRecording
@AFname varchar(50),
@ALname varchar(50),
@RecordingName varchar (50),
@InstrumentName varchar (50)

AS

BEGIN

DECLARE @ArtistID int
DECLARE @RecordingID int
DECLARE @InstrumentID int

SET @ArtistID = (SELECT ArtistID FROM [dbo].[Artist] WHERE ArtistFname = @AFname AND ArtistLname = @ALname)
SET @RecordingID = (SELECT RecordingID FROM [dbo].[Recording] WHERE RecordingName = @RecordingName)
SET @InstrumentID = (SELECT InstrumentID FROM [dbo].[Instrument] WHERE InstrumentName = @InstrumentName)

INSERT INTO [dbo].[Artist_Recording](ArtistID, RecordingID, InstrumentID)
VALUES (@ArtistID, @RecordingID, @InstrumentID)

END

EXECUTE addArtistRecording @AFname = "Beyonce", @ALname = "Knowles", @RecordingName = "SummerOriginal", @InstrumentName = "Trumpet"
EXECUTE addArtistRecording @AFname = "Solange", @ALname = "Knowles", @RecordingName = "SummerCover", @InstrumentName = "Tuba"
EXECUTE addArtistRecording @AFname = "Sam", @ALname = "Smith", @RecordingName = "SorryOriginal", @InstrumentName = "Sax"
EXECUTE addArtistRecording @AFname = "Mariah", @ALname = "Carey", @RecordingName = "SorryCover", @InstrumentName = "Flute"
EXECUTE addArtistRecording @AFname = "Ariana", @ALname = "Grande", @RecordingName = "DarkHorseOriginal", @InstrumentName = "Piccolo"
EXECUTE addArtistRecording @AFname = "Kanye", @ALname = "West", @RecordingName = "DarkHorseCover", @InstrumentName = "Guitar"
EXECUTE addArtistRecording @AFname = "Katy", @ALname = "Perry", @RecordingName = "RipideOriginal", @InstrumentName = "Viola"
EXECUTE addArtistRecording @AFname = "Kendrick", @ALname = "Lamar", @RecordingName = "RipideCover", @InstrumentName = "Cello"
EXECUTE addArtistRecording @AFname = "Jay", @ALname = "Cole", @RecordingName = "MapOriginal", @InstrumentName = "Octobass"
EXECUTE addArtistRecording @AFname = "Pixie", @ALname = "Lott", @RecordingName = "MapCover", @InstrumentName = "Violin"
____________________________________
Artist_Recording_Role

GO
CREATE PROCEDURE addArtRecRole
@AFname varchar(20), 
@ALname varchar(20), 
@Rname varchar(20)
AS 
BEGIN 
	DECLARE @ArtRecID INT
	DECLARE @RoID INT
	DECLARE @ArtID INT
	SET @RoID = (Select RoleID FROM [dbo].[position] WHERE RoleName = @Rname) 
	SET @ArtID = (SELECT ArtistID FROM [dbo].[Artist] WHERE ArtistFname = @AFname AND ArtistLname = @ALname)
	SET @ArtRecID = (Select ArtistRecordingID FROM [dbo].[Artist_Recording] WHERE ArtistID = @ArtID )
	INSERT INTO [dbo].[Artist_Recording_Role](ArtistRecordingID, RoleID)
	VALUES (@ArtRecID, @RoID) 
END 

EXECUTE addArtRecRole @AFname = "Pixie", @ALname = "Lott", @Rname = "Singer"
EXECUTE addArtRecRole @AFname = "Solange", @ALname = "Knowles", @Rname = "Singer"
EXECUTE addArtRecRole @AFname = "Sam", @ALname = "Smith", @Rname = "Singer"
EXECUTE addArtRecRole @AFname = "Mariah", @ALname = "Carey", @Rname = "Singer"
EXECUTE addArtRecRole @AFname = "Ariana", @ALname = "Grande", @Rname = "Singer"
EXECUTE addArtRecRole @AFname = "Kanye", @ALname = "West", @Rname = "Singer"
EXECUTE addArtRecRole @AFname = "Katy", @ALname = "Perry", @Rname = "Singer"
EXECUTE addArtRecRole @AFname = "Kendrick", @ALname = "Lamar", @Rname = "Singer"
EXECUTE addArtRecRole @AFname = "Beyonce", @ALname = "Knowles", @Rname = "Singer"
EXECUTE addArtRecRole @AFname = "Jay", @ALname = "Cole", @Rname = "Singer"
