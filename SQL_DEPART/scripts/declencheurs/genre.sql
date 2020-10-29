CREATE OR REPLACE TRIGGER Genre_TRG
BEFORE UPDATE 
ON JEU
FOR EACH ROW

BEGIN
    
    if (:old.codegenre != :new.codegenre)
    then
        delete from sous_genre_jeu where idJeu = :old.idJeu;
    end if;


END;
/