CREATE OR REPLACE FUNCTION joueurLePlusPopulaire
RETURN JOUEUR.SURNOM%TYPE
IS
    
BEGIN
    SELECT JOUEUR.NOJOUEUR, COUNT(AMI.CODESTATUT) FROM AMI, JOUEUR WHERE AMI.NOJOUEURINVITANT = JOUEUR.NOJOUEUR OR AMI.NOJOUEURINVITE = JOUEUR.NOJOUEUR GROUP BY JOUEUR.NOJOUEUR;
END;