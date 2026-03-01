/* 
--TP1 SQL — Série TP



1. Lister tous les étudiants.
SELECT * FROM etudiants;

2. Nom et prénom de tous les enseignants.
SELECT nom, prenom FROM enseignants;

3. Cours + nom de l’enseignant responsable.
SELECT c.id_cours, c.intitule, e.nom AS nom_enseignant, e.prenom AS prenom_enseignant
FROM cours c
JOIN enseignants e ON e.id_ens = c.id_ens
ORDER BY c.intitule;

4. Inscriptions + étudiant + intitulé du cours.
SELECT i.id_insc, et.nom AS nom_etudiant, et.prenom AS prenom_etudiant,
       c.intitule, i.date_inscription, i.note
FROM inscriptions i
JOIN etudiants et ON et.id_etud = i.id_etud
JOIN cours c ON c.id_cours = i.id_cours
ORDER BY i.date_inscription DESC;

5. Étudiants nés après 2002-01-01.
SELECT * FROM etudiants
WHERE date_naissance > '2002-01-01'
ORDER BY date_naissance;

6. Cours dispensés par l’enseignant "Petit".
SELECT c.*
FROM cours c
JOIN enseignants e ON e.id_ens = c.id_ens
WHERE e.nom = 'Petit'
ORDER BY c.intitule;

7. Pour chaque cours, nombre total d’inscriptions.
SELECT c.id_cours, c.intitule, COUNT(i.id_insc) AS total_inscriptions
FROM cours c
LEFT JOIN inscriptions i ON i.id_cours = c.id_cours
GROUP BY c.id_cours, c.intitule
ORDER BY total_inscriptions DESC, c.intitule;

8. Cours ayant plus de 5 inscriptions.
SELECT c.id_cours, c.intitule, COUNT(i.id_insc) AS total_inscriptions
FROM cours c
JOIN inscriptions i ON i.id_cours = c.id_cours
GROUP BY c.id_cours, c.intitule
HAVING COUNT(i.id_insc) > 5
ORDER BY total_inscriptions DESC;

9. Étudiants n’ayant suivi aucun cours.
SELECT et.*
FROM etudiants et
LEFT JOIN inscriptions i ON i.id_etud = et.id_etud
WHERE i.id_insc IS NULL
ORDER BY et.nom, et.prenom;

10. Enseignants n’ayant dispensé aucun cours.
SELECT e.*
FROM enseignants e
LEFT JOIN cours c ON c.id_ens = e.id_ens
WHERE c.id_cours IS NULL
ORDER BY e.nom, e.prenom;

11. Note moyenne obtenue dans chaque cours.
SELECT c.id_cours, c.intitule, AVG(i.note) AS moyenne_cours
FROM cours c
JOIN inscriptions i ON i.id_cours = c.id_cours
GROUP BY c.id_cours, c.intitule
ORDER BY moyenne_cours DESC;

12. Moyenne générale de chaque étudiant.
SELECT et.id_etud, et.nom, et.prenom, AVG(i.note) AS moyenne_generale
FROM etudiants et
JOIN inscriptions i ON i.id_etud = et.id_etud
GROUP BY et.id_etud, et.nom, et.prenom
ORDER BY moyenne_generale DESC;

13. Étudiants dont la moyenne générale >= 14.
SELECT et.id_etud, et.nom, et.prenom, AVG(i.note) AS moyenne_generale
FROM etudiants et
JOIN inscriptions i ON i.id_etud = et.id_etud
GROUP BY et.id_etud, et.nom, et.prenom
HAVING AVG(i.note) >= 14
ORDER BY moyenne_generale DESC;

14. Cours dont la moyenne des notes < 12.
SELECT c.id_cours, c.intitule, AVG(i.note) AS moyenne_cours
FROM cours c
JOIN inscriptions i ON i.id_cours = c.id_cours
GROUP BY c.id_cours, c.intitule
HAVING AVG(i.note) < 12
ORDER BY moyenne_cours ASC;

15. Étudiants dont le nom contient "an".
SELECT * FROM etudiants
WHERE nom LIKE '%an%'
ORDER BY nom, prenom;

16. Inscriptions entre 2025-02-01 et 2025-03-31.
SELECT * FROM inscriptions
WHERE date_inscription BETWEEN '2025-02-01' AND '2025-03-31'
ORDER BY date_inscription;

17. Inscriptions dont la note est dans (10,12,14).
SELECT * FROM inscriptions
WHERE note IN (10, 12, 14)
ORDER BY note, date_inscription;

18. Étudiants qui ont au moins une inscription.
SELECT et.*
FROM etudiants et
WHERE EXISTS (
  SELECT 1 FROM inscriptions i
  WHERE i.id_etud = et.id_etud
)
ORDER BY et.nom, et.prenom;

19. Cours pour lesquels aucun étudiant ne s’est inscrit.
SELECT c.*
FROM cours c
WHERE NOT EXISTS (
  SELECT 1 FROM inscriptions i
  WHERE i.id_cours = c.id_cours
)
ORDER BY c.intitule;

20. Vue vue_cours_inscrits (intitulé, enseignant, nb inscrits).
CREATE OR REPLACE VIEW vue_cours_inscrits AS
SELECT c.id_cours,
       c.intitule,
       CONCAT(e.prenom, ' ', e.nom) AS enseignant,
       COUNT(i.id_insc) AS nb_inscrits
FROM cours c
JOIN enseignants e ON e.id_ens = c.id_ens
LEFT JOIN inscriptions i ON i.id_cours = c.id_cours
GROUP BY c.id_cours, c.intitule, e.prenom, e.nom;
