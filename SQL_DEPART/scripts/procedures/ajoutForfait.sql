CREATE OR REPLACE PROCEDURE ajoutForfait(
    Code IN FORFAIT.CODE%TYPE,
    Nom IN FORFAIT.NOM%TYPE,
    Description IN FORFAIT.DESCRIPTION%TYPE,
    Prix IN PERIODE.PRIX%TYPE
    )
IS
    NomForfait FORFAIT.CODE%TYPE;
    Today DATE;
BEGIN
    SELECT SYSDATE INTO Today FROM DUAL;
    NomForfait := Nom;
    
    IF (NomForfait IS NULL)
    THEN
        NomForfait := 'DEFAULT';
    END IF;
    
    INSERT INTO FORFAIT VALUES (Code, Nom, Description);
    INSERT INTO PERIODE (DATEDEBUT, DATEFIN, PRIX, CODEFORFAIT) VALUES (Today, add_months(Today, 12), Prix, Code);
    
END;
/
    
