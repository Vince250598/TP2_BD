CREATE OR REPLACE VIEW suiviReseau
as select  suivi_reseau.moment,suivi_reseau.action, suivi_reseau.codereseau, reseau.nom from suivi_reseau
join reseau on suivi_reseau.codereseau = reseau.code
where suivi_reseau.nojoueur is null
order by suivi_reseau.moment;/


CREATE OR REPLACE VIEW SuiviReseayJoueur
as select suivi_reseau.moment, suivi_reseau.action, suivi_reseau.codereseau, joueur.surnom  from suivi_reseau
join joueur on suivi_reseau.nojoueur = joueur.nojoueur 
where suivi_reseau.nojoueur is not null
order by suivi_reseau.moment;/ 
