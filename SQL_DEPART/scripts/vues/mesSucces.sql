CREATE OR REPLACE VIEW MesSucces
as select SUCCES.Titre, succes.description, succes.valeur, succes_realise.nojoueur from SUCCES_REALISE
JOIN SUCCES on SUCCES.IdSucces = succes_realise.idsucces

union
select succes.titre, succes.description, succes.valeur, succes_en_cours.nojoueur from succes_en_cours
join succes on succes.idsucces = succes_en_cours.idsucces;/