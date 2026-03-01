# TD2 — Algèbre relationnelle — BD AIRBASE (Corrigé)

Schéma :
- PILOTE(NUMPIL, NOMPIL, ADR, SAL)
- AVION(NUMAV, NOMAV, CAP, LOC)
- VOL(NUMVOL, NUMPIL, NUMAV, VILLE_DEP, VILLE_ARR, H_DEP, H_ARR)

Opérateurs :
- sélection σ, projection π, jointure ⨝, union ∪, différence −, renommage ρ.

---

## a) Sélections / projections

**Q1** π_{NUMAV,NOMAV,CAP,LOC}( σ_{CAP>350}(AVION) )  
**Q2** π_{NUMAV,NOMAV}( σ_{LOC='Nice'}(AVION) )  
**Q3** π_{NUMPIL, VILLE_DEP}(VOL)  
**Q4** PILOTE  
**Q5** π_{NOMPIL}( σ_{ADR='Paris' ∧ SAL>15000}(PILOTE) )  
**Q6** π_{NUMAV,NOMAV}( σ_{LOC='Nice' ∨ CAP<350}(AVION) )  
**Q7** π_{NUMVOL,VILLE_DEP,VILLE_ARR,H_DEP}( σ_{VILLE_DEP='Nice' ∧ VILLE_ARR='Paris' ∧ H_DEP>18}(VOL) )  
**Q8** π_{NUMPIL}(PILOTE) − π_{NUMPIL}(VOL)  
**Q9** π_{NUMVOL,VILLE_DEP}( σ_{NUMPIL=100 ∨ NUMPIL=204}(VOL) )

---

## b) Jointures

**Q10** π_{NUMVOL}( σ_{VILLE_DEP='Nice' ∧ ADR='Nice'}( VOL ⨝_{VOL.NUMPIL=PILOTE.NUMPIL} PILOTE ) )

**Q11** π_{NUMVOL,VILLE_DEP,VILLE_ARR}( σ_{LOC<>'Nice'}( VOL ⨝_{VOL.NUMAV=AVION.NUMAV} AVION ) )

**Q12** π_{PILOTE.NUMPIL,PILOTE.NOMPIL}(
σ_{VILLE_DEP='Nice' ∧ CAP>300}(
(PILOTE ⨝_{PILOTE.NUMPIL=VOL.NUMPIL} VOL) ⨝_{VOL.NUMAV=AVION.NUMAV} AVION
))

**Q13** π_{PILOTE.NOMPIL}(
σ_{ADR='Paris' ∧ VILLE_DEP='Nice' ∧ NOMAV='Airbus'}(
(PILOTE ⨝_{PILOTE.NUMPIL=VOL.NUMPIL} VOL) ⨝_{VOL.NUMAV=AVION.NUMAV} AVION
))

**Q14** π_{NUMVOL}(
σ_{ADR='Nice' ∧ (VILLE_DEP='Nice' ∨ VILLE_ARR='Nice') ∧ LOC='Paris'}(
(PILOTE ⨝_{PILOTE.NUMPIL=VOL.NUMPIL} VOL) ⨝_{VOL.NUMAV=AVION.NUMAV} AVION
))

**Q15**
A = π_{VILLE_ARR}( σ_{VILLE_DEP='Paris'}(VOL) )  
Résultat = π_{V2.VILLE_ARR}( A ⨝_{A.VILLE_ARR = V2.VILLE_DEP} ρ_{V2}(VOL) )

**Q16** π_{PILOTE.NUMPIL,PILOTE.NOMPIL}(
σ_{ADR = VILLE_DEP}( PILOTE ⨝_{PILOTE.NUMPIL=VOL.NUMPIL} VOL )
)
