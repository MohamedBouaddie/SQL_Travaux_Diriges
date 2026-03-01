# TD1 — Modèle Conceptuel des Données (MCD) — Corrigé (proposition)

Notation : **Entité**(clé, attributs...)  
Association avec cardinalités (min,max).

---

## Exercice 1 : Réservation d’hôtel

### Entités
- **CLIENT**(idClient, nom, prenom, email, telephone)
- **CHAMBRE**(idChambre, numero, type, prixParNuit)
- **RESERVATION**(idResa, dateArrivee, dateDepart)
- **PAIEMENT**(idPaiement, datePaiement, montant)

### Associations / Cardinalités
- CLIENT (1,n) — *effectue* — RESERVATION (1,1)
- CHAMBRE (1,n) — *concerne* — RESERVATION (1,1)
- RESERVATION (1,1) — *donne_lieu_a* — PAIEMENT (1,n)

---

## Exercice 2 : Location de voitures

### Entités
- **CLIENT**(idClient, nom, prenom, email, telephone)
- **MODELE**(idModele, marque, nomModele)
- **VOITURE**(idVoiture, immatriculation, prixParJour)
- **RESERVATION**(idResa, dateDebut, dateFin)
- **PAIEMENT**(idPaiement, datePaiement, montantTotal)

### Associations / Cardinalités
- MODELE (1,n) — *caracterise* — VOITURE (1,1)
- CLIENT (1,n) — *effectue* — RESERVATION (1,1)
- VOITURE (1,n) — *est_reservee_dans* — RESERVATION (1,1)
- RESERVATION (1,1) — *est_payee_par* — PAIEMENT (1,1)

---

## Exercice 3 : Restaurant

### Entités
- **CLIENT**(idClient, nom, telephone)
- **TABLE_RESTO**(idTable, numero, capacite)
- **SERVEUR**(idServeur, nom)
- **RESERVATION**(idResa, dateResa, heureResa, nbPersonnes)
- **COMMANDE**(idCmd, dateCmd, montantTotal)
- **PLAT**(idPlat, nomPlat, prix)

### Associations / Cardinalités
- CLIENT (1,n) — *fait* — RESERVATION (1,1)
- RESERVATION (1,1) — *reserve* — TABLE_RESTO (1,n)
- SERVEUR (1,n) — *est_affecte_a* — TABLE_RESTO (1,n)
- CLIENT (1,n) — *passe* — COMMANDE (1,1)
- COMMANDE (1,n) — *contient* — PLAT (1,n)
  - (Option recommandé : assoc. **LIGNE_COMMANDE**(quantite))

---

## Exercice 4 : Système scolaire

### Entités
- **ELEVE**(idEleve, nom, prenom, dateNaissance)
- **ENSEIGNANT**(idEns, nom, prenom)
- **MATIERE**(idMat, libelle)
- **COURS**(idCours, dateCours)

### Associations / Cardinalités
- ENSEIGNANT (1,n) — *dispense* — COURS (1,1)
- MATIERE (1,n) — *concerne* — COURS (1,1)
- ELEVE (1,n) — *suit* — COURS (1,n) avec attribut **note**
  - Association **SUIVRE**(note)
- ENSEIGNANT (0,n) — *responsable_de* — MATIERE (1,n)
  - Si 1 seul responsable par matière : MATIERE (1,1) — responsable — ENSEIGNANT (0,n)
