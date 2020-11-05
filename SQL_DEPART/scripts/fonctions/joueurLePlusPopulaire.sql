CREATE OR REPLACE FUNCTION joueurLePlusPopulaire
RETURN JOUEUR.SURNOM%TYPE
IS
    CURSOR cur_joueurPlusPopulaire IS
    SELECT JOUEUR.NOJOUEUR 
    FROM AMI, JOUEUR 
    WHERE AMI.NOJOUEURINVITANT = JOUEUR.NOJOUEUR 
    OR AMI.NOJOUEURINVITE = JOUEUR.NOJOUEUR 
    GROUP BY JOUEUR.NOJOUEUR 
    ORDER BY COUNT(AMI.CODESTATUT) DESC;
    noJoueurPlusPopulaire JOUEUR.NOJOUEUR%TYPE;
    joueurPlusPopulaire JOUEUR%ROWTYPE;
BEGIN
    OPEN cur_joueurPlusPopulaire;
    FETCH cur_joueurPlusPopulaire INTO noJoueurPlusPopulaire;
   
    WHILE cur_joueurPlusPopulaire%FOUND LOOP
        SELECT JOUEUR.* INTO joueurPlusPopulaire FROM JOUEUR WHERE NOJOUEUR = noJoueurPlusPopulaire;
        IF (joueurPlusPopulaire.NOM IS NOT NULL AND joueurPlusPopulaire.PRENOM IS NOT NULL AND joueurPlusPopulaire.ACTIF = 1) THEN
            RETURN joueurPlusPopulaire.SURNOM;
        END IF;
        FETCH cur_joueurPlusPopulaire INTO noJoueurPlusPopulaire;
    END LOOP;
   
    CLOSE cur_joueurPlusPopulaire;
    
    RETURN NULL;
   
END;