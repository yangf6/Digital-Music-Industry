
/*We want to limit the quantity of music download by free/ student premium subscriber from any online music industry, for example,
Spotify. So in this way, company can attract more people become their premium subscriber or student premium subscriber*/
CREATE FUNCTION dbo.download(@SubscriptionID INT,@AccessTypeName INT)
RETURNS int
AS
BEGIN
DECLARE @feedback int = 0
IF EXISTS(Select S.SubscriptionID,count(A.AccessID)AS number  FROM Access A
JOIN Subscription S ON A.SubscriptionID = S.SubscriptionID
JOIN Access_Type AT ON A.AccessTypeID = AT.AccessTypeID
JOIN Subscription_Type ST ON S.SubscriptionTypeID = ST.SubscriptionTypeID
WHERE AT.AccessTypeID = @AccessTypeID and S.SubscriptionID = @SubscriptionID
GROUP BY S.SubscriptionID
HAVING COUNT(A.AccessID) > 7)
SET @feedback = 1
RETURN @feedback
END

ALTER TABLE Access
ADD CONSTRAINT CK_DOWNLOAD
CHECK (dbo.download(SubscriptionID,AccessID) = 0)

SELECT dbo.download(11,2) AS checking
GO
