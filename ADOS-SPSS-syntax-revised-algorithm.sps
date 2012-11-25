***********************************************************************************************************************.
* syntax written by Phillip Gorrindo - pgorrindo.github@gorrindo.com
* last updated on November 25, 2012
* Git repository at https://github.com/pgorrindo/ADOS-SPSS
* .
* SPSS Syntax to score the Autism Diagnostic Observation Schedule (ADOS)
* for autism spectrum disorder (ASD) classifications, using the revised scoring algorithm, for ADOS modules 1-3.
* as of now, there aren't revised classification cutoffs for module 4.
* Reference for the revised scoring algorithm is here: http://www.ncbi.nlm.nih.gov/pubmed/17180459 
* .
* Some notes on the following code:
*    - there are some required variables that this code expects (i.e. study_group, etc) which your database may not have; 
*       please consider this code as the starting point that you can build on and will, most likely, need to modify to work for your particular dataset
*    - use this code at your own risk... I can't guarantee that I'll be able to help you troubleshoot if a problem comes up
*    - if you find an error, please let me know
*    - a version of this code has been used in analysis of data that has been published in peer-reviewed reports.
*    - this code allows for a manually coded classification (already stored in the dataset), and will calculate a classification based on individual items, 
*        and then check the two against each other
* .
***********************************************************************************************************************.


**************************************************.
**************************************************.
* first create two variables for the revised classification system's two domains
  namely, "Social Affect" and "Restricted and Repetitive Behavior"
  as well as another variable for the sum of these two
  and a variable for the calculated revised classification.
**************************************************.
NUMERIC ados_revisclass_socafftot_calc (F5.0).
VARIABLE LABELS ados_revisclass_socafftot_calc "ADOS revised classification - Social Affect total - calculated".
VARIABLE LEVEL ados_revisclass_socafftot_calc (SCALE).

NUMERIC ados_revisclass_rrbtot_calc (F5.0).
VARIABLE LABELS ados_revisclass_rrbtot_calc "ADOS revised classification - R&R Behavior total - calculated".
VARIABLE LEVEL ados_revisclass_rrbtot_calc (SCALE).

NUMERIC ados_revisclass_socaffrrbtot_calc (F5.0).
VARIABLE LABELS ados_revisclass_socaffrrbtot_calc "ADOS revised classification - Social Affect + RRB total - calculated".
VARIABLE LEVEL ados_revisclass_socaffrrbtot_calc (SCALE).

NUMERIC ados_revisclassif_calc (F5.0).
VARIABLE LABELS ados_revisclassif_calc "ADOS revised classification - calculated".
VALUE LABELS ados_revisclassif_calc 
	1 'autism'
	2 'autism spectrum'
	3 'does not meet cutoffs'.
VARIABLE LEVEL ados_revisclassif_calc (NOMINAL).

EXECUTE.
***************************************************.
***************************************************.


**************************************************.
**************************************************.
* for the revised totals, scores of 3 are converted to 2; and any score other than 0 to 3 is treated as a 0.
*
* mod1: a2, a8, b1, b3, b4, b5, b9, b10, b11, b12, a3, d1, d2, d4, a7, a5
   mod2: a7, a8, b1, b2, b3, b5, b6, b8, b10, b11, a5, d1, d2, d4
   mod3: a7, a8, a9, b1, b2, b4, b7, b8, b9, b10, a4, d1, d2, d4.
* individual item scores are recoded here in SPSS into a new variable, with an "r" appended, to be used in adding below.
* ref: (old=new).
* ref: RECODE var1 (SYSMIS=-9) (ELSE=COPY).
**************************************************.
RECODE ados_mod1_a2 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_a2r.
RECODE ados_mod1_a3 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_a3r.
RECODE ados_mod1_a5 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_a5r.
RECODE ados_mod1_a7 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_a7r.
RECODE ados_mod1_a8 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_a8r.

RECODE ados_mod1_b1 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_b1r.
RECODE ados_mod1_b3 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_b3r.
RECODE ados_mod1_b4 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_b4r.
RECODE ados_mod1_b5 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_b5r.
RECODE ados_mod1_b9 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_b9r.
RECODE ados_mod1_b10 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_b10r.
RECODE ados_mod1_b11 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_b11r.
RECODE ados_mod1_b12 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_b12r.

RECODE ados_mod1_d1 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_d1r.
RECODE ados_mod1_d2 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_d2r.
RECODE ados_mod1_d4 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod1_d4r.

RECODE ados_mod2_a5 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_a5r.
RECODE ados_mod2_a7 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_a7r.
RECODE ados_mod2_a8 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_a8r.

RECODE ados_mod2_b1 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_b1r.
RECODE ados_mod2_b2 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_b2r.
RECODE ados_mod2_b3 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_b3r.
RECODE ados_mod2_b5 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_b5r.
RECODE ados_mod2_b6 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_b6r.
RECODE ados_mod2_b8 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_b8r.
RECODE ados_mod2_b10 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_b10r.
RECODE ados_mod2_b11 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_b11r.

RECODE ados_mod2_d1 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_d1r.
RECODE ados_mod2_d2 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_d2r.
RECODE ados_mod2_d4 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod2_d4r.

RECODE ados_mod3_a4 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_a4r.
RECODE ados_mod3_a7 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_a7r.
RECODE ados_mod3_a8 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_a8r.
RECODE ados_mod3_a9 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_a9r.

RECODE ados_mod3_b1 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_b1r.
RECODE ados_mod3_b2 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_b2r.
RECODE ados_mod3_b4 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_b4r.
RECODE ados_mod3_b7 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_b7r.
RECODE ados_mod3_b8 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_b8r.
RECODE ados_mod3_b9 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_b9r.
RECODE ados_mod3_b10 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_b10r.

RECODE ados_mod3_d1 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_d1r.
RECODE ados_mod3_d2 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_d2r.
RECODE ados_mod3_d4 (0=0) (1=1) (2=2) (3=2) (ELSE=0) INTO ados_mod3_d4r.

EXECUTE.

**************************************************.
**************************************************.


**************************************************.
**************************************************.
*now calculate autism (AU) and autism spectrum (ASD) revised classifications based on subdomain scores.
* cut-off thresholds are included for reference, in the format of AU_cutoff_value/ASD_cutoff_value.
*
* big DO IF loop here to only act on cases that have an ADOS module.
**************************************************.
DO IF (MISSING(ados_module) <> 1).

************************** 
module 1, no words: 16/11
no words means a 3 or 8 on item A1.
DO IF ((ados_module = 1) AND ((ados_mod1_a1= 3) OR (ados_mod1_a1= 8))).
  COMPUTE ados_revisclass_socafftot_calc = sum(ados_mod1_a2r, ados_mod1_a8r, ados_mod1_b1r, ados_mod1_b3r,
    ados_mod1_b4r, ados_mod1_b5r, ados_mod1_b9r, ados_mod1_b10r, ados_mod1_b11r, ados_mod1_b12r).

  COMPUTE ados_revisclass_rrbtot_calc = sum(ados_mod1_a3r, ados_mod1_d1r, ados_mod1_d2r, ados_mod1_d4r).

  COMPUTE ados_revisclass_socaffrrbtot_calc = sum(ados_revisclass_socafftot_calc, ados_revisclass_rrbtot_calc).

  DO IF (ados_revisclass_socaffrrbtot_calc >= 16).
    COMPUTE ados_revisclassif_calc=1.
    * autism.
  ELSE IF (ados_revisclass_socaffrrbtot_calc >= 11).
    COMPUTE ados_revisclassif_calc=2.
    * autism spectrum.
  ELSE.
    COMPUTE ados_revisclassif_calc=3.
  END IF.
END IF.


************************** 
module 1, some words: 12/8
some words means a 0, 1, or 2 on item A1.
DO IF ((ados_module = 1) AND (ados_mod1_a1 <= 2)).
  COMPUTE ados_revisclass_socafftot_calc = sum(ados_mod1_a2r, ados_mod1_a7r, ados_mod1_a8r, ados_mod1_b1r, ados_mod1_b3r,
    ados_mod1_b4r, ados_mod1_b5r, ados_mod1_b9r, ados_mod1_b10r, ados_mod1_b12r).

  COMPUTE ados_revisclass_rrbtot_calc = sum(ados_mod1_a5r, ados_mod1_d1r, ados_mod1_d2r, ados_mod1_d4r).

  COMPUTE ados_revisclass_socaffrrbtot_calc = sum(ados_revisclass_socafftot_calc, ados_revisclass_rrbtot_calc).

  DO IF (ados_revisclass_socaffrrbtot_calc >= 12).
    COMPUTE ados_revisclassif_calc=1.
    * autism.
  ELSE IF (ados_revisclass_socaffrrbtot_calc >= 8).
    COMPUTE ados_revisclassif_calc=2.
    * autism spectrum.
  ELSE.
    COMPUTE ados_revisclassif_calc=3.
  END IF.
END IF.


************************** 
module 2, younger than 5: 10/7.
DO IF ((ados_module = 2) AND (age_calc_yrs_ados < 5)).
  COMPUTE ados_revisclass_socafftot_calc = sum(ados_mod2_a7r, ados_mod2_a8r, ados_mod2_b1r, ados_mod2_b2r, ados_mod2_b3r,
    ados_mod2_b5r, ados_mod2_b6r, ados_mod2_b8r, ados_mod2_b10r, ados_mod2_b11r).

  COMPUTE ados_revisclass_rrbtot_calc = sum(ados_mod2_a5r, ados_mod2_d1r, ados_mod2_d2r, ados_mod2_d4r).

  COMPUTE ados_revisclass_socaffrrbtot_calc = sum(ados_revisclass_socafftot_calc, ados_revisclass_rrbtot_calc).

  DO IF (ados_revisclass_socaffrrbtot_calc >= 10).
    COMPUTE ados_revisclassif_calc=1.
    * autism.
  ELSE IF (ados_revisclass_socaffrrbtot_calc >= 7).
    COMPUTE ados_revisclassif_calc=2.
    * autism spectrum.
  ELSE.
    COMPUTE ados_revisclassif_calc=3.
  END IF.
END IF.


************************** 
module 2, 5 years or older: 9/8.
DO IF ((ados_module = 2) AND (age_calc_yrs_ados >= 5)).
  COMPUTE ados_revisclass_socafftot_calc = sum(ados_mod2_a7r, ados_mod2_a8r, ados_mod2_b1r, ados_mod2_b2r, ados_mod2_b3r,
    ados_mod2_b5r, ados_mod2_b6r, ados_mod2_b8r, ados_mod2_b10r, ados_mod2_b11r).

  COMPUTE ados_revisclass_rrbtot_calc = sum(ados_mod2_a5r, ados_mod2_d1r, ados_mod2_d2r, ados_mod2_d4r).

  COMPUTE ados_revisclass_socaffrrbtot_calc = sum(ados_revisclass_socafftot_calc, ados_revisclass_rrbtot_calc).

  DO IF (ados_revisclass_socaffrrbtot_calc >= 9).
    COMPUTE ados_revisclassif_calc=1.
    * autism.
  ELSE IF (ados_revisclass_socaffrrbtot_calc >= 8).
    COMPUTE ados_revisclassif_calc=2.
    * autism spectrum.
  ELSE.
    COMPUTE ados_revisclassif_calc=3.
  END IF.
END IF.


************************** 
module 3: 9/7.
DO IF (ados_module = 3).
  COMPUTE ados_revisclass_socafftot_calc = sum(ados_mod3_a7r, ados_mod3_a8r, ados_mod3_a9r, ados_mod3_b1r, ados_mod3_b2r,
    ados_mod3_b4r, ados_mod3_b7r, ados_mod3_b8r, ados_mod3_b9r, ados_mod3_b10r).

  COMPUTE ados_revisclass_rrbtot_calc = sum(ados_mod3_a4r, ados_mod3_d1r, ados_mod3_d2r, ados_mod3_d4r).

  COMPUTE ados_revisclass_socaffrrbtot_calc = sum(ados_revisclass_socafftot_calc, ados_revisclass_rrbtot_calc).

  DO IF (ados_revisclass_socaffrrbtot_calc >= 9).
    COMPUTE ados_revisclassif_calc=1.
    * autism.
  ELSE IF (ados_revisclass_socaffrrbtot_calc >= 7).
    COMPUTE ados_revisclassif_calc=2.
    * autism spectrum.
  ELSE.
    COMPUTE ados_revisclassif_calc=3.
  END IF.
END IF.


************************** 
module 4: .
****as of now, there aren't revised classification cutoffs for module 4.


END IF.
EXECUTE.
***************************************************.
***************************************************.


**************************************************.
**************************************************.
*now check the calculated revised classification versus the revised classification stored in REDCap.
**************************************************.
NUMERIC ados_revisclassif_agree_manual_calc (F3.0).
VARIABLE LABELS ados_revisclassif_agree_manual_calc "ADOS revised classification - agreement between calculated and manual".
VALUE LABELS ados_revisclassif_agree_manual_calc 
	0 'do not agree'
	1 'agree'.
VARIABLE LEVEL ados_revisclassif_agree_manual_calc (NOMINAL).
EXECUTE.


DO IF (MISSING(ados_revis_classif) <> 1).
  DO IF (ados_revis_classif = ados_revisclassif_calc).
    COMPUTE ados_revisclassif_agree_manual_calc=1.
  ELSE IF (ados_revis_classif <> ados_revisclassif_calc).
    COMPUTE ados_revisclassif_agree_manual_calc=0.
  END IF.
END IF.
EXECUTE.


EXECUTE.
***************************************************.
***************************************************.


**************************************************.
**************************************************.
*now check the calculated revised classification total score versus that stored in REDCap.
**************************************************.
NUMERIC ados_revisclass_totscore_diff_calc (F5.0).
VARIABLE LABELS ados_revisclass_totscore_diff_calc "ADOS revised classification - difference in Social Affect + RRB total scores - calculated".
VARIABLE LEVEL ados_revisclass_totscore_diff_calc (SCALE).
COMPUTE ados_revisclass_totscore_diff_calc = ados_revisclass_socaffrrbtot_calc -ados_revis_total_score.
EXECUTE.

**************************************************.
**************************************************.


* delete the temporary recoded variables used for summation.
DELETE VARIABLES
  ados_mod1_a2r
  ados_mod1_a3r
  ados_mod1_a5r
  ados_mod1_a7r
  ados_mod1_a8r
  ados_mod1_b1r
  ados_mod1_b3r
  ados_mod1_b4r
  ados_mod1_b5r
  ados_mod1_b9r
  ados_mod1_b10r
  ados_mod1_b11r
  ados_mod1_b12r
  ados_mod1_d1r
  ados_mod1_d2r
  ados_mod1_d4r
  ados_mod2_a5r
  ados_mod2_a7r
  ados_mod2_a8r
  ados_mod2_b1r
  ados_mod2_b2r
  ados_mod2_b3r
  ados_mod2_b5r
  ados_mod2_b6r
  ados_mod2_b8r
  ados_mod2_b10r
  ados_mod2_b11r
  ados_mod2_d1r
  ados_mod2_d2r
  ados_mod2_d4r
  ados_mod3_a4r
  ados_mod3_a7r
  ados_mod3_a8r
  ados_mod3_a9r
  ados_mod3_b1r
  ados_mod3_b2r
  ados_mod3_b4r
  ados_mod3_b7r
  ados_mod3_b8r
  ados_mod3_b9r
  ados_mod3_b10r
  ados_mod3_d1r
  ados_mod3_d2r
  ados_mod3_d4r.


CROSSTABS
  /TABLES=ados_revisclassif_agree_manual_calc BY study_group
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT COLUMN
  /COUNT ROUND CELL.


VARIABLE ATTRIBUTE VARIABLES=
  ados_revisclassif_calc
  ados_revis_classif
  ados_revisclassif_agree_manual_calc
  ados_revisclass_socafftot_calc
  ados_revisclass_rrbtot_calc
  ados_revisclass_socaffrrbtot_calc
  ados_sever_score
  ados_revis_total_score
  ados_revisclass_totscore_diff_calc
  ATTRIBUTE=origsort ('0013').

SORT VARIABLES BY ATTRIBUTE origsort (A).


SORT CASES BY
  include_flag (A)
  ados_revisclassif_agree_manual_calc (D)
  ados_module (A).


EXECUTE.


