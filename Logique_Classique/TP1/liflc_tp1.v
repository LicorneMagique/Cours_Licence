
(* On introduit les variables propositionnelles avec lesquelles 
   on va travailler par la suite *)
Context (P Q R A Z J F M S T: Prop).

(**********************************************************************)
(* Exercice 1 LA FLÈCHE  ***********************)
(* - axiome : assumption
   - introduction de la flèche : intro [nom qu'on donne à l'hypothèse] 
   - élimination de la flèche : apply [nom de l'hypothèse utilisée] *)
Theorem exercice_1a: P -> (P -> Q) -> Q.
Proof.
intros.
apply H0.
apply H.
Qed.


Theorem exercice_1b: (P -> Q) -> (Q -> R) -> (P -> R).
Proof.
intros.
apply H0.
apply H.
apply H1.
Qed.

(* Exercice 2 LE ET  ***********************)
(* Une variante de la question précédente avec /\ *)
(* - décomposition du /\ en hypothèse : destruct [nom de l'hypothèse avec /\]
*)
Theorem exercice_2a: (P -> Q) /\ (Q -> R) -> (P -> R).
Proof.
intros.
destruct H.
apply H1.
apply H.
apply H0.
Qed.

(* - introduction du /\ : split *)
(* On obtient bien deux sous-buts *)
Theorem exercice_2b : P -> Q -> P /\ Q.
Proof.
intros.
split.
- apply H.
- apply H0.
Qed.
  
(* Exercice 3 LE OU  ***********************)
(* introduction du ou :
   - depuis la droite : right
   - depuis la gauche : left

   decomposition du \/ en hypothèse : destruct *)

Theorem exercice_3a: (P \/ Q) -> (Q \/ P).
Proof.
intros.
destruct H.
right.
assumption.
left.
assumption.
Qed.

(* ---------------------------------------------------------------------*)


(* zéro constructeur *)
Print False. 
(* un seul constructeur car une seule règle d'intro *)
Print and.
(* deux constructeurs car deux règles d'intro*)
Print or.  

(* destruct donne bien un sous but par constructeur *)
(* On remarque que comme False n'a aucun constructeur : le destruct
résoud le but *)
Theorem ex_falso_quodlibet : False ->  P.
Proof.
intros H.
destruct H.
Qed.

(** un peu difficile **)
(* Plus généralement, la tactique exfalso remplace tout but par False. *)
(* Si on peut déduire False des hypothèses, c'est alors gagné ! *)

Theorem ex_falso_quodlibet_Q : (A -> False) -> A -> (P \/ (Q -> Z /\ J) -> F).
Proof.
  intro hafalse.
  intro ha.
  (* ces hypothèses permettent clairement de produire False *)
  (* on simplifie tout puisque le but ne sert plus à rien *)
  exfalso.
  (* et on produit False *)
  apply hafalse.
  assumption.
Qed.


(* À partir de maintenant on peut penser à nommer les hypothèses qui
apparaissent dans les destruct avec "as" et suivant le nombre de sous-buts *)
(* ---------------------------------------------------------------------*)


(* Exercice 4 PREMIÈRE MODÉLISATION  ***********************)
(* Modéliser l'exercice de TD "Zoé va à Paris", prouver que Zoé va à Paris *)
(* - introduction du /\ : split
*)
Theorem zoe_va_a_paris : ((A /\ J -> Z) /\ (J -> A) /\ (J \/ Z)) -> Z.
Proof.
intros.
destruct H.
destruct H0.
destruct H1.
apply H.
split.
- apply H0.
  apply H1.
- apply H1.
- apply H1.
Qed.

(* Exercice 5 LE NOT *************************)

(* - la notation not : unfold not
   - la notation not en hypothèse : unfold not in [nom de l'hypothèse avec ~]
*)
Theorem exercice_5a : (~P \/ ~Q) -> ~(P /\ Q).
Proof.
intros.
unfold not in H.
unfold not.
destruct H.
- intros.
  destruct H0.
  apply H.
  apply H0.
- intros.
  destruct H0.
  apply H.
  apply H1.
Qed.

(* Si on a toto et ~toto dans les hypothèses, alors le but est résolu avec "contradiction." *)

Theorem exercice_5b : P -> ~P -> Q.
Proof.
  intros.
  contradiction.
Qed.

(**********************************************************************)
(* Exercice 6 LE TIERS-EXCLU *)

(* On introduit la règle de tiers-exclu. *)
Context (Tiers_exclus: forall X: Prop, X \/ ~X).

(* Pour l'utiliser, c'est-à-dire pour avoir deux sous buts, un avec toto en hypothèse, l'autre avec ~toto, on invoquera :
   destruct (Tiers_exclus toto).
*)


Theorem exercice_6a: ((P -> Q) -> P) -> P.
Proof.
destruct (Tiers_exclus P).
- intros.
  apply H.
- intros.
  apply H0.
  contradiction.
Qed.

(* Deuxième modélisation *)
(* Modéliser l'exercice de TD "Frodon va au Mordor", prouver que Frodon est triste *)

(*Theorem exercice_6b : .
Proof.
Qed.
*)

(* Quid de ~~P et P ? *)
Theorem exercice_6c: (~~P -> P) /\ (P -> ~~P).
(* Pour l'un des deux sens on aura besoin du tiers-exclu et, en remarquant qu'on peut déduire False des hypothèses, de la simplification "exfalso". *)

Proof.
split.
- intros.
  unfold not in H.
  destruct (Tiers_exclus P).
  + apply H0.
  + exfalso.
  contradiction.
-  intros.
  unfold not.
  destruct (Tiers_exclus False).
  + contradiction.
  + contradiction.
Qed.
