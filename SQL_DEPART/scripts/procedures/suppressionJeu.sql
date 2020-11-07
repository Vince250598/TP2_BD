SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE suppressionJeu(
    CodeExecution OUT NUMBER,
    NomDuJeu IN JEU.NOM%TYPE
    )
IS
    JeuExiste NUMBER;
    ContenuPossedeCount NUMBER;
    IdJeuASupprimer JEU.IDJEU%TYPE;
BEGIN
    SELECT COUNT(JEU.IDJEU) INTO JeuExiste FROM JEU WHERE NOM = NomDuJeu;
    IF(JeuExiste = 0) THEN
        CodeExecution := 1;
        RETURN;
    ELSIF(JeuExiste > 1) THEN
        CodeExecution := 2;
        RETURN;
    END IF;

    SELECT COUNT(CONTENU_POSSEDE.IDCONTENU) INTO ContenuPossedeCount FROM JEU
    JOIN CONTENU ON CONTENU.IDJEU = JEU.IDJEU
    JOIN CONTENU_POSSEDE ON CONTENU.IDCONTENU = CONTENU_POSSEDE.IDCONTENU
    WHERE JEU.NOM = NomDuJeu;
    IF (ContenuPossedeCount > 0) THEN
        CodeExecution := 3;
        RETURN;
    END IF;
    
    SELECT IDJEU INTO IdJeuASupprimer FROM JEU WHERE NOM = NomDuJeu;
    
        BEGIN
            SAVEPOINT before_delete;
    
            DELETE SOUS_GENRE_JEU WHERE IDJEU = IdJeuASupprimer;
    
            DELETE SUCCES_CALCULE WHERE IDSUCCES = (SELECT SUCCES.IDSUCCES FROM SUCCES WHERE SUCCES.IDCONTENU = (SELECT CONTENU.IDCONTENU FROM CONTENU WHERE CONTENU.IDJEU = IdJeuASupprimer));
    
            DELETE SUCCES WHERE SUCCES.IDCONTENU = (SELECT CONTENU.IDCONTENU FROM CONTENU WHERE CONTENU.IDJEU = IdJeuASupprimer);
    
            DELETE CONTENU WHERE IDJEU = IdJeuASupprimer;
    
            DELETE JEU WHERE NOM = NomDuJeu;
            
            CodeExecution := 0; 
            
        EXCEPTION
        
        WHEN OTHERS THEN
            ROLLBACK TO before_delete;
            CodeExecution := 3;
        END;
END;
/