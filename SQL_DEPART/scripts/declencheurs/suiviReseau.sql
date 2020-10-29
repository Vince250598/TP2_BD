CREATE OR REPLACE TRIGGER Suivi_Reseau_TRG
AFTER UPDATE OR INSERT 
ON RESEAU
FOR EACH ROW

DECLARE 
    currentMoment timestamp;
    currentAction SUIVI_RESEAU.ACTION%type;

BEGIN
     SELECT SYSTIMESTAMP into currentMoment FROM DUAL;
     
    if INSERTING  
    then
    currentAction := 'CRE';
               
    elsif UPDATING
    then
        if (:new.Actif = '1')   then
            currentAction := 'ACT';
        else
            currentAction := 'DES';
        end if;

     
    end if;
     

    insert into SUIVI_RESEAU ( codeReseau, DateSuivi, Action)
        VALUES(:new.code, currentMoment, currentAction );

   
    

END;
/