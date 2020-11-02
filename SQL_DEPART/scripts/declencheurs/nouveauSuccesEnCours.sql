CREATE OR REPLACE TRIGGER NouveauSuccesEnCours_TRG
BEFORE INSERT 
ON SUCCES_EN_COURS
FOR EACH ROW

--DECLARE COMPLETED_SUCCESS number:=0;

BEGIN

    --SELECT count(*) INTO COMPLETED_SUCCESS from SUCCES_REALISE where IdSucces = :NEW.IDSUCCES;
    --DBMS_OUTPUT.PUT_LINE('success: ' || COMPLETED_SUCCESS);
    --if we find a already existing success, don't insert
    --IF (COMPLETED_SUCCESS > 0)
    --THEN
    -- raise_application_error(-20000, 'Succès déjà complété.');
    --END IF;
    null;
    

END;
/