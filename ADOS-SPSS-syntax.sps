***********************************************************************************************************************.
* syntax written by Phillip Gorrindo - pgorrindo.github@gorrindo.com
* last updated on November 25, 2012
* Git repository at https://github.com/pgorrindo/ADOS-SPSS
* .
* SPSS Syntax to score the Autism Diagnostic Observation Schedule (ADOS)
* for autism spectrum disorder (ASD) classifications, using the original scoring algorithm.
* .
* Some notes on the following code:
*    - there are some required variables that this code expects (i.e. study_group, etc) which your database may not have; 
*       please consider this code as the starting point that you can build on and will, most likely, need to modify to work for your particular dataset
*    - use this code at your own risk... I can't guarantee that I'll be able to help you troubleshoot if a problem comes up
*    - if you find an error, please let me know
*    - a version of this code has been used in analysis of data that has been published in peer-reviewed reports.
* .
***********************************************************************************************************************.


**************************************************.
**************************************************.
*first re-cast variables that were spit out by redcap from strings to numerics.
**************************************************.
ALTER TYPE ados_mod1_comm_total (F5.0).
ALTER TYPE ados_mod1_soc_int_total (F5.0).
ALTER TYPE ados_mod1_comm_soc_int_tot (F5.0).
ALTER TYPE ados_mod1_play_total (F5.0).
ALTER TYPE ados_mod1_ster_behav_total (F5.0).

ALTER TYPE ados_mod2_comm_total (F5.0).
ALTER TYPE ados_mod2_soc_int_total (F5.0).
ALTER TYPE ados_mod2_comm_soc_int_tot (F5.0).
ALTER TYPE ados_mod2_imagination_tot (F5.0).
ALTER TYPE ados_mod2_ster_behav_total (F5.0).

ALTER TYPE ados_mod3_comm_total (F5.0).
ALTER TYPE ados_mod3_soc_int_total (F5.0).
ALTER TYPE ados_mod3_comm_soc_int_tot (F5.0).
ALTER TYPE ados_mod3_imagination_tot (F5.0).
ALTER TYPE ados_mod3_ster_behav_total (F5.0).

ALTER TYPE ados_mod4_comm_total (F5.0).
ALTER TYPE ados_mod4_soc_int_total (F5.0).
ALTER TYPE ados_mod4_comm_soc_int_tot (F5.0).
ALTER TYPE ados_mod4_imagination_tot (F5.0).
ALTER TYPE ados_mod4_ster_behav_total (F5.0).

EXECUTE.
***************************************************.
***************************************************.





**************************************************.
**************************************************.
*now calculate autism/autism spectrum classifications based on subdomain scores.
* cut-off thresholds are included for reference, in the format of SUBDOM-AU_cutoff_value/ASD_cutoff_value.
**************************************************.
NUMERIC ados_classif_calc (F5.0).
VARIABLE LABELS ados_classif_calc "ADOS classification - caluclated".
VALUE LABELS ados_classif_calc 
	1 'autism'
	2 'autism spectrum'
	3 'does not meet cutoffs'.
VARIABLE LEVEL ados_classif_calc (NOMINAL).
EXECUTE.

**************************************************.
**************************************************.



**************************************************.
**************************************************.
**** big DO IF loop here to only act on cases that have an ADOS module.
**************************************************.
DO IF (MISSING(psych_ados_module) <> 1).

************************** 
module 1: COMM 4/2;  SOCIN 7/4;   COMMSOCIN 12/7.
DO IF (psych_ados_module = 1).
  DO IF ((ados_mod1_comm_total >= 4) AND (ados_mod1_soc_int_total >= 7) AND (ados_mod1_comm_soc_int_tot >= 12)).
    COMPUTE ados_classif_calc=1.
    * autism.
  ELSE IF ((ados_mod1_comm_total >= 2) AND (ados_mod1_soc_int_total >= 4) AND (ados_mod1_comm_soc_int_tot >= 7)).
    COMPUTE ados_classif_calc=2.
    * autism spectrum.
  ELSE.
    COMPUTE ados_classif_calc=3.
  END IF.  
END IF.


************************** 
module 2: COMM 5/3;  SOCIN 6/4;   COMMSOCIN 12/8.
DO IF (psych_ados_module = 2).
  DO IF ((ados_mod2_comm_total >= 5) AND (ados_mod2_soc_int_total >= 6) AND (ados_mod2_comm_soc_int_tot >= 12)).
    COMPUTE ados_classif_calc=1.
    * autism.
  ELSE IF ((ados_mod2_comm_total >= 3) AND (ados_mod2_soc_int_total >= 4) AND (ados_mod2_comm_soc_int_tot >= 8)).
    COMPUTE ados_classif_calc=2.
    * autism spectrum.
  ELSE.
    COMPUTE ados_classif_calc=3.
  END IF.
END IF.


************************** 
module 3: COMM 3/2;  SOCIN 6/4;   COMMSOCIN 10/7.
DO IF (psych_ados_module = 3).
  DO IF ((ados_mod3_comm_total >= 3) AND (ados_mod3_soc_int_total >= 6) AND (ados_mod3_comm_soc_int_tot >= 10)).
    COMPUTE ados_classif_calc=1.
    * autism.
  ELSE IF ((ados_mod3_comm_total >= 2) AND (ados_mod3_soc_int_total >= 4) AND (ados_mod3_comm_soc_int_tot >= 7)).
    COMPUTE ados_classif_calc=2.
    * autism spectrum.
  ELSE.
    COMPUTE ados_classif_calc=3.
  END IF.
END IF.


************************** 
module 4: COMM 3/2;  SOCIN 6/4;   COMMSOCIN 10/7.
DO IF (psych_ados_module = 4).
  DO IF ((ados_mod4_comm_total >= 3) AND (ados_mod4_soc_int_total >= 6) AND (ados_mod4_comm_soc_int_tot >= 10)).
    COMPUTE ados_classif_calc=1.
    * autism.
  ELSE IF ((ados_mod4_comm_total >= 2) AND (ados_mod4_soc_int_total >= 4) AND (ados_mod4_comm_soc_int_tot >= 7)).
    COMPUTE ados_classif_calc=2.
    * autism spectrum.
  ELSE.
    COMPUTE ados_classif_calc=3.
  END IF.
END IF.



END IF.
EXECUTE.
***************************************************.
***************************************************.







**************************************************.
**************************************************.
*now check the calculated classification versus the classification stored in redcap.
**************************************************.
NUMERIC ados_classif_agree_evon_calc (F3.0).
VARIABLE LABELS ados_classif_agree_evon_calc "ADOS classification - agreement between calculated and evon".
VALUE LABELS ados_classif_agree_evon_calc 
	0 'do not agree'
	1 'agree'.
VARIABLE LEVEL ados_classif_agree_evon_calc (NOMINAL).
EXECUTE.

DO IF (MISSING(ados_classif2) <> 1).
  DO IF (ados_classif2 = ados_classif_calc).
    COMPUTE ados_classif_agree_evon_calc=1.
  ELSE IF (ados_classif2 <> ados_classif_calc).
    COMPUTE ados_classif_agree_evon_calc=0.
  END IF.
END IF.
EXECUTE.

EXECUTE.


CROSSTABS
  /TABLES=ados_classif_agree_evon_calc BY study_group2
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT COLUMN
  /COUNT ROUND CELL.
***************************************************.
***************************************************.



VARIABLE ATTRIBUTE VARIABLES=
  ados_classif_calc
  ados_classif2
  ados_classif_agree_evon_calc
  psych_ados_module
  ATTRIBUTE=origsort ('0012').


SORT VARIABLES BY ATTRIBUTE origsort (A).

SORT CASES BY
  include_flag (A)
  ados_classif_agree_evon_calc (D)
  psych_ados_module (A).


EXECUTE.











