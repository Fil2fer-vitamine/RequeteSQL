--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)
select * from potion p;		-- Il nous faut une Sélection de l'ensemble de par le '*' de la table 'potion'.
-- OK


--2. Liste des noms des trophées rapportant 3 points. (2 lignes)
select c.nom_categ
from categorie c 		-- Il nous faut une Sélection de "c.nom_categ" de la table 'categorie'
where c.nb_points = 3;	-- recherche de plusieurs lignes par rapport à un choix unique (ici : 3) --> l'opérateur logique '=' est à prendre en compte.
-- OK


--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)
select v.nom_village
from village v			-- Il nous faut une Sélection de "v.nom_village" de la table 'village'
where nb_huttes > 35;	-- recherche de plusieurs lignes par rapport à l'opérateur logique '>'
-- OK


--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)
select t.num_trophee, t.date_prise
from trophee t			-- Il nous faut une Sélection de "t.num_trophee" et de "t.date_prise" -- seule la table 'trophee' est prise en compte.
where t.date_prise		-- Où il y a une date de prise
between '2052-05-01' and '2052-06-30';	-- entre une date à une autre.
-- OK


--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)
select h.nom
from habitant h		-- Il nous faut une Sélection de "h.nom" de la table 'habitant'.
where h.nom
like 'A%r%';		-- Où "h.nom" comporte un 'A' pour premier caractère et où il y a un 'r' dans la chaine de caractères.
--OK



--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)
select distinct a.num_hab
from absorber a 		-- Il nous faut une Sélection de "a.num_hab" de la table 'absorber'.
where num_potion = 1 or num_potion = 3 or num_potion = 4;	-- Où "num_potion" est soit 1 OU 3 OU 4.
--OK


--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)
select t.num_trophee , t.date_prise , c.nom_categ , h.nom  from trophee t
join categorie c on c.code_cat = t.code_cat
join habitant h on h.num_hab = t.num_preneur;
-- Il nous faut une Sélection de "t.num_trophee", "t.date_prise" et "t.num_preneur" de la table 'trophee'.
-- OK
-- Correction au niveau du nom preneur.



--8. Nom des habitants qui habitent à Aquilona. (7 lignes)
select h.nom 
from habitant h 	-- Il nous faut une Sélection de "h.nom" de la table 'habitant'.
join village v ON v.num_village = h.num_village		-- ceci est une jointure entre les tables 'village' et 'habitant'
where v.nom_village = 'Aquilona';	-- recherche de lignes par rapport à une valeur unique --> l'opérateur logique '=' est à prendre en compte.
-- OK



--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)
select h.nom 
from habitant h  -- table 'habitant' est distante de 'trophee' et ensuite de 'categorie' où "nom_categ" se trouve.
join trophee t on t.num_preneur  = h.num_hab -- ceci est une jointure entre les tables 'trophee' et 'habitant'
join categorie c on c.code_cat = t.code_cat -- ceci est un autre jointure entre les tables 'categorie' et 'trophee'
where c.nom_categ = 'Bouclier de Légat';  -- recherche de lignes par rapport à une valeur unique --> l'opérateur logique '=' est à prendre en compte.
-- OK



--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)
select lib_potion , p.formule , p.constituant_principal 
from potion p -- Il nous faut une Sélection de "lib_potion" de la table 'potion' distante de 'fabriquer' et ensuite de 'habitant' où "h.nom" se trouve.
join fabriquer f on f.num_potion = p.num_potion  -- ceci est un jointure entre les tables 'fabriquer' et 'potion'
join habitant h on h.num_hab = f.num_hab  -- ceci est un autre jointure entre les tables 'habitant' et 'fabriquer'
where h.nom = 'Panoramix';	-- recherche de lignes par rapport à une valeur unique --> l'opérateur logique '=' est à prendre en compte.
-- OK
-- Correction en ajoutant la formule et constituant principal.



--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)
select DISTINCT lib_potion 	
from potion p 	-- Il nous faut une Sélection de "lib_potion" de la table 'potion' EN RETIRANT LES DOUBLONS (utilisation de DISTINCT).
join absorber a on a.num_potion = p.num_potion  -- ceci est un jointure entre les tables 'absorber' et 'potion'
join habitant h on h.num_hab = a.num_hab  -- ceci est un autre jointure entre les tables 'absorber' et 'habitant'
where h.nom = 'Homéopatix';	-- recherche de lignes par rapport à une valeur unique --> l'opérateur logique '=' est à prendre en compte.	
-- OK : Problème résolu avec le mot clé DISTINCT.



--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)
select distinct h.nom 
from habitant h	-- Il nous faut une Sélection de "h.nom" de la table 'habitant'
join absorber a on a.num_hab = h.num_hab  -- ceci est une jointure entre les tables 'absorber' et 'habitant'
join potion p on p.num_potion = a.num_potion -- ceci est une autre jointure entre les tables 'potion' et 'absorber'
join fabriquer f on f.num_potion = p.num_potion -- ceci est une autre jointure entre les tables 'fabriquer' et 'potion'
join habitant h2 on h2.num_hab = f.num_hab -- ceci est une autre jointure entre les tables 'habitant' et 'fabriquer' : Etant donnée que habitant a déjà été appelé, nous devons stipuler h2.
where f.num_potion = 3;		-- recherche de lignes par rapport à une valeur unique --> l'opérateur logique '=' est à prendre en compte.	




--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)
select distinct h.nom 
from habitant h 	-- Il nous faut une Sélection de "h.nom" de la table 'habitant'
join absorber a on a.num_hab = h.num_hab  -- ceci est une jointure entre les tables 'absorber' et 'habitant'
join potion p on p.num_potion = a.num_potion  -- -- ceci est une jointure entre les tables 'potion' et 'absorber'
join fabriquer f on f.num_potion = p.num_potion  -- -- ceci est une jointure entre les tables 'fabriquer' et 'potion'
join habitant h2 on f.num_hab = h2.num_hab  -- ceci est une jointure entre les tables 'fabriquer' et 'habitant' : Etant donnée que habitant a déjà été appelé, nous devons stipuler h2.
where h2.nom = 'Amnésix';	-- recherche de lignes par rapport à une valeur unique --> l'opérateur logique '=' est à prendre en compte.	
-- OK



--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)
select h.nom
from habitant h   	-- Il nous faut une Sélection de "h.nom" de la table 'habitant'
where h.num_qualite is null ;  -- Où 'h.num_qualite' est inexistant : utilisation du mot clé 'is null'
-- OK : la propriété num_qualite était déjà dans la table habitant.


--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de lapotion) en février 52. (3 lignes)
select h.nom    -- , a.date_a  
from habitant h	-- Il nous faut une Sélection de "h.nom" et "a.date_a" - Seule la table 'habitant' est en référence.
join absorber a on a.num_hab = h.num_hab	 -- ceci est une jointure entre les tables 'absorber' et 'habitant'
join potion p on p.num_potion = a.num_potion	-- ceci est une jointure entre les tables 'potion' et 'absorber'
where p.lib_potion = 'Potion magique n°1' 		-- recherche de lignes par rapport à une valeur unique --> l'opérateur logique '=' est à prendre en compte.	
and a.date_a between '2052-02-01' and '2052-02-29';		-- dans un intervale de temps.
--between '2052-02-01' and '2052-02-28'; 
--and a.date_a in (2052-02-01%); -- A revoir car il y a une erreur ... la notion du temps sur le mois de février, pouvant changer suivant si c'est une année bissextile, me perturbe ...
-- OK
-- Correction avec la date de 2052/02/29
-- Mise en commentaire de l'affichage de la date pour coller à l'énoncé.



--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)
select h.nom, h.age  
from habitant h -- Il nous faut une Sélection de "h.nom" et "h.age" de la table 'habitant'.
order by h.nom;  -- L'ordre chronologique est obtenu avec le mot clé 'ORDER BY'
-- OK




--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)
select r.nom_resserre, v.nom_village 
from resserre r		-- Il nous faut une Sélection de "r.nom_resserre" et "v.nom_village" de la table 'resserre' - Seule la table 'resserre' est en référence.
join village v on v.num_village = r.num_village 	 -- ceci est une jointure entre les tables 'village' et 'resserre'
order by r.superficie desc ;  -- L'ordre chronologique est obtenu avec le mot clé 'ORDER BY' - Cet ordre est inversé, soit descendant, à l'aide du mot clé 'DESC'
-- OK --> notion de classement descendant avec le mot clé DESC.




--***

--18. Nombre d'habitants du village numéro 5. (4)
select count(h.num_village)
from habitant h 	-- Il nous faut une Sélection de "h.num_village" de la table 'village' --> seulement, plusieurs lignes ont une valeur de 5 pour "h.num_village"
-- Nous faisons le compte de toutes ces lignes avec la méthode count() au niveau de la sélection.
where h.num_village = 5; -- recherche de lignes par rapport à une valeur unique --> l'opérateur logique '=' est à prendre en compte.	
-- Nous avons, sans la méthode count(), plusieurs lignes, ... et non un nombre d'habitants.
-- OK



--19. Nombre de points gagnés par Goudurix. (5)
select sum(c.nb_points)  
from categorie c		-- Il nous faut une Sélection de "c.nb_points" de la table 'categorie' --> seulement, plusieurs lignes sont ressorties
join trophee t on c.code_cat = t.code_cat 	 -- ceci est une jointure entre les tables 'categorie' et 'trophee'
join habitant h on t.num_preneur = h.num_hab  	 -- ceci est une jointure entre les tables 'trophee' et 'habitant'
where h.nom = 'Goudurix'; 		-- recherche de lignes par rapport à une valeur unique --> l'opérateur logique '=' est à prendre en compte.	
-- OK - On s'est aperçu que les parenthèses ne sont pas obligatoires au niveau de where h.nom = ('Goudurix')



--20. Date de première prise de trophée. (03/04/52)
-- select min(date_prise) 
-- from trophee t; 						-- J'étais resté sur cette solution, ...
-- Or, la solution trouvée ne répondait pas à la question : on recherche une date au formalisme français, ... et non américain

select to_char(min(t.date_prise), 'DD/MM/YY') 
from trophee t;		-- Il nous faut une Sélection de "t.date_prise" dans le tableau 'trophee'
-- pour avoir la valeur la plus basse, il y a utilisation de la méthode MIN().
-- pour obtenir un certain formalisme, à savoir passer une date américaine à une date française,
-- --> utilisation de la méthode to_chart()
-- OK




--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)
select sum(a.quantite) 
from absorber a 		-- Il nous faut une Sélection de "a.quantite" dans le tableau 'absorber'
join potion p on a.num_potion = p.num_potion	-- ceci est une jointure entre les tables 'absorber' et 'potion'
where p.lib_potion = ('Potion magique n°2');	 		-- Où il y a une valeur unique --> l'opérateur logique '=' est à prendre en compte.	
-- OK



--22. Superficie de la plus grande resserre. (895)
select max(r.superficie)
from resserre r;	-- Il nous faut une Sélection de "r.superficie" dans le tableau 'resserre'
-- la méthode MAX() nous permet d'obtenir la valeur la plus haute.
-- OK



--***

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)
select v.nom_village, count(h.num_village)
from habitant h	-- Il nous faut une Sélection de "v.nom_village" et "h.nom" - Seul le tableau 'absorber' est paramétré.
join village v on v.num_village = h.num_village	-- ceci est une jointure entre les tables 'village' et 'habitant'
group by v.nom_village;  -- pour l'affichage dès que la sélection est multiple.
-- Utilisation de la méthode count() pour compter les lignes.
-- Utilisation du mot clé DISTINCT pour enlever les doublons.
-- OK

-- Attention : pas besoin de mettre le DISTINCT si nous n'avons pas de doublon ...




--24. Nombre de trophées par habitant (6 lignes)
select h.nom, count(t.num_trophee) 
from habitant h	-- Il nous faut une Sélection de "h.nom" et "t.num_trophee" - Seul le tableau 'habitant' est paramétré.
join trophee t on h.num_hab = t.num_preneur	-- ceci est une jointure entre les tables 'trophee' et 'habitant'
group by h.nom;	  -- pour l'affichage dès que la sélection est multiple.

-- Il y a plusieurs trophee pour trois habitants : en mettant distinct, plus rien ne fonctionne ... Pourquoi ? Cela doit venit du fait que l'on ait deux sélections : 'habitant' et 'trophee'
-- Il nous faut compter le nombre de trophee par habitant : la methode count() nous le permet.
-- Si je sélectionne le nom des habitants, je me dois de le grouper aux comptes de trophee : GROUP BY nous le permet.
-- OK

-- Attention : pas besoin de mettre le DISTINCT si nous n'avons pas de doublon ...

select h.nom, count (t.num_preneur) 
from trophee t 		-- Il nous faut une Sélection de "h.nom" et "t.num_preneur" - Seul le tableau 'habitant' est paramétré.
join habitant h on t.num_preneur = h.num_hab -- ceci est une jointure entre les tables 'trophee' et 'habitant'
group by h.nom;	  -- pour l'affichage dès que la sélection est multiple.
-- Cette solution a été trouvée par Soélie (ceci fait ressortir le t.num_preneur).
--> le 'num_preneur' a été pris en compte pour le comptage.




--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)
select p.nom_province, AVG(h.age) 
from habitant h -- Il nous faut une Sélection de "p.nom_province" et "h.age" - Seul le tableau 'province' est paramétré.
join village v on v.num_village = h.num_village -- ceci est une jointure entre les tables 'village' et 'habitant'
join province p on p.num_province = v.num_province -- ceci est une jointure entre les tables 'province' et 'village'
group by p.nom_province;	  -- pour l'affichage dès que la sélection est multiple.
-- La méthode AVG() renvoi la moyenne.
-- Il y avait un Message d'erreur de syntaxe sur grouping by
-- J'en ai pourtant besoin car il me faut grouper deux sélections ???
-- Il me faut suivre impérativement le chemin --> habitant - village - province --> L'ordre dans lequel on met les jointures est IMPORTANT.
-- OK

select p.nom_province, round(AVG(h.age),+2) 
from habitant h -- Il nous faut une Sélection de "p.nom_province" et "h.age" - Seul le tableau 'province' est paramétré.
join village v on v.num_village = h.num_village -- ceci est une jointure entre les tables 'village' et 'habitant'
join province p on p.num_province = v.num_province -- ceci est une jointure entre les tables 'province' et 'village'
group by p.nom_province;

-- Cette solution parait meilleure car il y a deux chiffres après la virgule : utilisation de round().



--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)
select h.nom ,count(distinct a.num_potion)
from habitant h    -- Il nous faut une Sélection de "h.nom" et "a.num_potion" - Seul le tableau 'habitant' est paramétré.
join absorber a on a.num_hab = h.num_hab -- ceci est une jointure entre la table 'absorber' et 'habitant'
group by h.nom ;  	  -- pour l'affichage dès que la sélection est multiple.






--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)
select h.nom, a.quantite, p.lib_potion  
from habitant h    -- Il nous faut une Sélection de "h.nom" et "a.quantite" - Seul le tableau 'habitant' est paramétré ---> Je sélectionne également "p.lib_potion" pour voir qu'effectivement il n'y a qu'une ligne : le problème résidait sur les majuscules 'Potion Zen', au lieu de 'potion zen' 
join absorber a on a.num_hab = h.num_hab -- ceci est une jointure entre la table 'absorber' et 'habitant'
join potion p on p.num_potion = a.num_potion -- ceci est une jointure entre la table 'potion' et 'absorber'
where a.quantite > 2 and p.lib_potion = 'Potion Zen'; -- Où il y a une valeur unique --> l'opérateur logique '>' est à prendre en compte.	
--> (a.quantite > 2) AND (p.lib_potion = 'potion zen')




--***
--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)
select v.nom_village  
from village v		-- Il nous faut une Sélection de TOUT dans le tableau 'village'
join resserre r on r.num_village = v.num_village	-- ceci est une jointure entre la table 'resserre' et 'village'
-- "where num_resserre <> 0;"  -- on s'est aperçu que si l'on ne met pas un where, on a le même affichage !
-- OK ... pas, en fait, même si cela marche, ce n'est pas la bonne approche ...
-- ... is not null serait la bonne direction, après en avoir discuté avec Johann et Louis.
 where r.num_resserre is not null;		-- Le mot cle 'is not null' permet d'écarter toutes les réponses ayant la valeur 'NULL'




--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)
select v.nom_village, v.nb_huttes 
from village v			-- Il nous faut une Sélection de "v.nom_village" et de "v.nb_huttes" dans le tableau 'village'
order by v.nb_huttes desc		-- order by permet le tri par ordre alphabétique
FETCH FIRST 1 row ONLY;		-- limit 1 donnerait la même chose.
-- DESC permet le tri alphabétique par ordre DESCENDANT.

-- 7 lignes apparaissent, on ne veut que la première ???



select v.nom_village  from village v 
order by nb_huttes desc limit 1;
-- Cette solution a été trouvée par Soélie
--> 'limit' permet de spécifier le nombre maximum de résultats que l’ont souhaite obtenir

select v.nom_village  from village v
where v.nb_huttes = (select max(v2.nb_huttes)from village v2);
-- Cette solution a été trouvée par Soélie
--> il y a possibilité de prendre la valeur max de 'nb.huttes' et de réaffecter la valeur.


--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).
-- Essai 1 : Echec
--select distinct h.nom, sum(t.date_prise)
--from habitant h 	-- Il nous faut une Sélection de "h.nom" et de "t.date_prise" - Seul le tableau 'habitant' est paramétré.
--join trophee t on t.num_preneur  = h.num_hab	-- ceci est une jointure entre la table 'trophee' et 'habitant'
--group by h.nom;  	-- pour l'affichage dès que la sélection est multiple.
--having SUM(t.date_prise) > 40



-- Essai 2 : Echec
--join (select t.date_prise, h2.num_hab  from trophee t where h2.nom  > 'Obélix') as yoohoooooo on t.num_preneur = h.num_hab 
--group by h.nom, t.date_prise ;  -- Prise de 'date_prise' en référence pour cet exercice, ... plutôt que 'num_preneur' ...
-- Echec : référence invalide d'une entrée de la clause FROM pour la table « h » Indice : Il existe une entrée pour la table « h » mais elle ne peut pas être référencée de cette partie de la requête.
--> Essai de joindre h2 ?!?
-- Echec autre : Il existe une entrée pour la table « h2 » mais elle ne peut pas être référencée de cette partie de la requête.

-- Essai 3 : Echec
--order by  t.num_preneur > (select t2.num_preneur from trophee t2 where h.nom = 'Obélix' );
--if t.num_trophee > ((select t2.num_trophee from trophee t2)
--select h2.nom from habitant h2  where h2.nom = 'Obélix');

-- Essai 4 : Echec
--select h.nom, t.date_prise from habitant h
--join trophee t on t.num_trophee = h.num_hab 
--group by (h.nom, (select t2.date_prise from trophee t2 where t2.date_prise > ));


-- Essai 5 : Echec
-- select h.nom, count (t.num_preneur) as nbtrophee from trophee t 
-- join habitant h on t.num_preneur = h.num_hab 
-- where h.nom > 'Obélix'
-- group by h.nom;


select h.nom, count (t.num_preneur) 
from trophee t 		-- Il nous faut une Sélection de "h.nom" et "t.num_preneur" - Seul le tableau 'habitant' est paramétré.
join habitant h on t.num_preneur = h.num_hab -- ceci est une jointure entre les tables 'trophee' et 'habitant'
group by h.nom;  	-- Nous obtenons les six personnages ayant des trophees, ... Obélix y compris. Il nous faut un opérateur logique '>' ...
					-- Si nous écrivons groupe by h.nom = 'Obélix'; --> ERREUR:
					-- --> la colonne « h.nom » doit apparaître dans la clause GROUP BY ou doit être utilisé dans une fonction d'agrégat
					-- ... mais avec quel valeur représentant Obélix ?

-- Essai 6 : Echec.
					-- Il nous faut cette logique > à la même logique appliquer juste pour Obélix.




-- REPONSE A LA QUESTION 30 en combinant la réponse 24 par le biais de deux select :
-- Cette solution a été trouvée par Soélie (ceci fait ressortir le t.num_preneur).

select h.nom, count (t.num_preneur) 		-- Quand il y a un opérateur sup ou inf, il faut impérativement le mot clé 'having'
-- 'having' se place après 'groupe by' :  select --> from --> join --> groupe by --> having
from trophee t 		
join habitant h on t.num_preneur = h.num_hab 
group by h.nom		-- il y a deux éléments dans le premier select : utilisation de 'groupe by'.
having count (t.num_preneur) > (select count (t2.num_preneur)			-- Le having ne fait la différence qu'entre deux conteurs semblables. 
-- La première sélection prend en compte tous les personnages ayant des trophees.
-- La deuxième sélection prend en compte le nombre de trophées pour Obélix
-- ... d'où le calcul induisant HAVING élément 1 > élément 2.
-- Emploi de 2 pour les indicatifs du deuxième select car on ne réutilise pas les tables d'origine pour le calcul.
								from trophee t2 		 
								join habitant h2 on t2.num_preneur = h2.num_hab 
								where h2.nom = 'Obélix');		-- il n'y a qu'un élément dans le deuxième select : utilisation de 'where'.
							-- Indentation souhaitée pour la lisibilité.





