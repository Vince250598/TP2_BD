SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE prolongationForfait(
    CodeForfaitRecherche IN FORFAIT.CODE%TYPE,
    PlayerCount OUT NUMBER
    )
IS
    rec_PERIODE_FORFAIT_JOUEUR PERIODE_FORFAIT_JOUEUR%ROWTYPE;
    Today DATE;
    
    CURSOR cur_PERIODE_FORFAIT_JOUEUR IS
    SELECT * FROM PERIODE_FORFAIT_JOUEUR WHERE
    IDPERIODE IN (SELECT PERIODE.IDPERIODE FROM PERIODE WHERE CODEFORFAIT = CodeForfaitRecherche)
    FOR UPDATE;
BEGIN
    PlayerCount := 0;

    SELECT SYSDATE INTO Today FROM DUAL;
    
    OPEN cur_PERIODE_FORFAIT_JOUEUR;

    FETCH cur_PERIODE_FORFAIT_JOUEUR INTO rec_PERIODE_FORFAIT_JOUEUR;
    WHILE cur_PERIODE_FORFAIT_JOUEUR%FOUND LOOP
        IF (rec_PERIODE_FORFAIT_JOUEUR.DATEACHAT >= add_months(Today, -12)) 
        THEN
            UPDATE PERIODE_FORFAIT_JOUEUR SET DATEACHAT = add_months(DATEACHAT, 2)
            WHERE CURRENT OF cur_PERIODE_FORFAIT_JOUEUR;
            PlayerCount := PlayerCount + 1;
        END IF;
        
        FETCH cur_PERIODE_FORFAIT_JOUEUR INTO rec_PERIODE_FORFAIT_JOUEUR;
    END LOOP;
    
    
    CLOSE cur_PERIODE_FORFAIT_JOUEUR;
    
END;
/