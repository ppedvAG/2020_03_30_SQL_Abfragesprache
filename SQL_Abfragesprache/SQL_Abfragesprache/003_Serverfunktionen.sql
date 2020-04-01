-- häufige Serverfunktionen

-- ********************** TRIM, LEN, DATALENGTH *******************************

SELECT 'Test'

SELECT 'Leo'

SELECT 'Leo     '

-- eventuell vorhandene, unerwünschte Leerzeichen können mit einem TRIM weggeschnitten werden

SELECT RTRIM('Leo     ') -- schneidet Leerzeichen rechts weg
SELECT LTRIM('     Leo') -- schneidet Leerzeichen links weg
SELECT TRIM('     Leo     ') -- schneidet Leerzeichen auf beiden Seiten weg


SELECT LEN('Leo     ') -- 3 - wieviele Zeichen sind da tatsächlich vorhanden (exklusive Leerzeichen am Schluss)

SELECT LEN('     Leo') -- 8 - Zeichen inklusive Leerzeichen davor


SELECT LEN('     Leo     ') -- 8 (die am Anfang ja, die am Ende nein)

SELECT DATALENGTH('     Leo     ') -- 13 Zeichen (wieviele sind es insgesamt)


SELECT DATALENGTH(RTRIM('Leo     '))

-- Vorsicht bei Datentyp nchar - doppelt so viel (wegen Unicode)



--Angenommen, durch einen Fehler gibt es Leerzeichen in einem String:
--'    Test    '
--.a) Entferne die Leerzeichen
--.b) Gib die Länge des Strings vorher und nachher in einer Tabelle aus:

SELECT LEN('     Test     ') -- bringt hier nix
SELECT DATALENGTH('     Test     ') -- aha!
SELECT TRIM('     Test     ') -- Leerzeichen weg

SELECT	  DATALENGTH('     Test     ') AS Vorher
		, DATALENGTH(TRIM('     Test     ')) AS Nachher


-- ****************************** REVERSE ***********************************

SELECT REVERSE('REITTIER')
SELECT REVERSE('Trug Tim eine so helle Hose nie mit Gurt?')


-- *********************** AUSSCHNEIDEN: LEFT, RIGHT, SUBSTRING ******************
-- Zeichen "ausschneiden":

-- schneidet die ersten vier Zeichen aus:
SELECT LEFT('Testtext', 4)


-- schneidet die letzten vier Zeichen aus:
SELECT RIGHT('Testtext', 4)


-- Textausschnitt mit SUBSTRING:
SELECT SUBSTRING('Testtext', 4, 2) -- tt
-- wovon möchten wir ausschneiden?
-- von welcher Stelle ausgehend? (4)
-- wieviele Zeichen wollen wir ausschneiden(2)


-- ******************************* STUFF **********************************
-- Zeichen einfügen ("reinstopfen")

SELECT STUFF('Testtext', 5, 0, '_Hallo_') -- _Hallo_ wird "reingestopft"
SELECT STUFF('Testtext', 5, 2, '_Hallo_') -- Test_Hallo_xt - '_Hallo_' ersetzt 'te'


--Die letzten drei Stellen einer Telefonnummer sollen durch xxx ersetzt werden:
--z.B.:  +49 86779889xxx

-- Möglichkeit 1:
SELECT STUFF('0123456789', 8, 3, 'xxx') 
-- geht nur für Telefonnummern mit gleicher Länge!


-- Möglichkeit 2:
SELECT LEFT('0123456789', 7) + 'xxx'
-- geht nur für Telefonnummern mit gleicher Länge!

SELECT 'abc' + 'cde' -- Strings können so zusammengefügt werden, ist aber nicht besonders schön

-- Möglichkeit 3:
SELECT STUFF('0123456789', (LEN('0123456789')-2), 3, 'xxx')
-- funktioniert unabhängig von Länge, weil die Stelle, an der wir einfügen (bzw. weglöschen), berechnet wird


-- Möglichkeit 4:
-- langsam:
SELECT REVERSE('0123456789') -- 9876543210

SELECT STUFF('9876543210', 1, 3, 'xxx') -- xxx6543210

SELECT REVERSE('xxx6543210')

-- zusammenstückeln:
SELECT REVERSE(STUFF(REVERSE('0123456789'), 1, 3, 'xxx'))
-- auch das funktioniert unabhängig davon, wie viele Zeichen vorhanden sind


-- ************************* CONCAT - Strings zusammenfügen ********************
-- Strings zusammenfügen mit CONCAT() (steht für concatenate)

SELECT CONCAT('abc', 'def', 'ghi', 'jkl', 'mno', 'pqr', 'stu', 'vwx', 'yz')

SELECT CONCAT('Ich weiß, ', 'dass ich', ' nichts weiß.') AS Zitat

SELECT CONCAT('James', 'Bond')

SELECT CONCAT('James', ' ', 'Bond') AS FullName


-- ******************* REPLICATE - Zeichen mehrfach ausgeben *****************
-- ein Zeichen oder auch eine Zeichenfolge mehrfach ausgeben

SELECT REPLICATE('?', 5) -- ?????
SELECT REPLICATE('x', 3) -- xxx

SELECT REPLICATE('abc', 3)-- abcabcabc



-- ****************************** Groß- und Kleinbuchstaben ********************
-- alles in Großbuchstaben ausgeben:
SELECT UPPER('abc')




-- alles in Kleinbuchstaben ausgeben:
SELECT LOWER('ABC')



-- ***************************** REPLACE ****************************
-- ganz bestimmte Zeichen ersetzen mit REPLACE

SELECT REPLACE('Hallo!', 'a', 'e') -- Hello!
-- in welcher Zeichenfolge möchten wir etwas ersetzen?
-- welches Zeichen möchten wir ersetzen? (a)
-- womit möchten wir es ersetzen (e)


-- mehrere Zeichen ersetzen ist möglich mit verschachtelten REPLACE:
SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?')
SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?'), 'H', 'B')



-- ************************** CHARINDEX ************************************
-- an welcher Stelle befindet sich ein gesuchtes Zeichen?
-- Buchstabe:
SELECT CHARINDEX('a', 'Leo') -- 0
-- wonach suchen wir? (a)
-- wo suchen wir danach? (Leo)
-- 0 heißt: kommt darin nicht vor


SELECT CHARINDEX('a', 'Hallo') -- 2

-- Groß-/Kleinschreibung spielt keine Rolle:
SELECT CHARINDEX('h', 'Hallo') -- 1
SELECT CHARINDEX('O', 'Hallo') -- 5

-- nach Leerzeichen suchen:
SELECT CHARINDEX(' ' , 'James Bond') -- 6

-- auch nach Sonderzeichen suchen funktioniert:
SELECT CHARINDEX('$', '450$') -- 4
SELECT CHARINDEX('%', '50%') -- 3


-- wir können nach ganzen Zeichenfolgen suchen:
SELECT CHARINDEX('schnecke', 'Zuckerschnecke') -- 7
-- wir erhalten die erste Stelle, an der unsere Zeichenfolge beginnt


-- CHARINDEX gibt die ERSTE Stelle an, an der sich das gesuchte Zeichen befindet
SELECT CHARINDEX(' ', 'Wolfgang Amadeus Mozart') -- 9


-- wie bekomme ich hier das letzte Leerzeichen?
-- langsam:

SELECT REVERSE('Wolfgang Amadeus Mozart') -- trazoM suedamA gnagfloW

SELECT CHARINDEX(' ' , 'trazoM suedamA gnagfloW') -- 7

SELECT LEN('Wolfgang Amadeus Mozart') -- 23


-- 23 - 7 = 16
-- 16 + 1 = Stelle, wo sich das letzte Leerzeichen befindet


SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ' , REVERSE('Wolfgang Amadeus Mozart')) + 1 -- 17!


SELECT LEN('Georg Friedrich Händel') - CHARINDEX(' ' , REVERSE('Georg Friedrich Händel')) + 1 -- 16


SELECT LEN('Johann Sebastian Bach') - CHARINDEX(' ' , REVERSE('Johann Sebastian Bach')) + 1 -- 17



