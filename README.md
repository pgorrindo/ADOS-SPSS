ADOS-SPSS
========

## Synopsis

The Autism Diagnostic Observation Schedule (ADOS) is a standardized assessment of social interaction and communication used in diagnostic evaluations of individuals with a possible autism spectrum disorder (ASD).

As described by the publisher ([WPS](http://portal.wpspublish.com/pls/portal/url/page/wps/W-365)):

> "This semi-structured assessment can be used to evaluate almost anyone suspected of having autism -- 
> from toddlers to adults, from children with no speech to adults who are verbally fluent. 
> The ADOS consists of various activities that allow you to observe social and communication behaviors 
> related to the diagnosis of pervasive developmental disorders. These activities provide interesting, 
> standard contexts in which interaction can occur."

[This Git repository](https://github.com/pgorrindo/ADOS-SPSS) contains code to score the ADOS (catalog #W-365 at [WPS](http://portal.wpspublish.com/pls/portal/url/page/wps/W-365)) using IBM's SPSS statistical program, generating final ASD classifications for individual cases from raw ADOS item scores.

There are two versions of this code, in separate files:
*	[ADOS-SPSS-syntax.sps](https://github.com/pgorrindo/ADOS-SPSS/blob/master/ADOS-SPSS-syntax.sps) - used to score ADOS modules 1-4 with the original scoring algorithm
*	[ADOS-SPSS-syntax-revised-algorithm.sps](https://github.com/pgorrindo/ADOS-SPSS/blob/master/ADOS-SPSS-syntax-revised-algorithm.sps) - used to score ADOS modules 1-3 with the revised scoring algorithm (see [Gotham et al, J Autism Dev Disord. 2007 Apr;37(4):613-27](http://www.ncbi.nlm.nih.gov/pubmed/17180459)). At the time of writing this code, revised classification cutoffs for module 4 were not available.

This code was written by Phillip Gorrindo (pgorrindo.github@gorrindo.com) and tested using SPSS version 19. If you find an error, please let me know. Please use this code at your own risk. I can't guarantee that I'll be able to help you troubleshoot if a problem comes up. A version of this code has been used in analysis of data that has been published after peer-review (i.e. [here](http://gorrindo.com/phillip/professional-portfolio/2012/04/gastrointestinal-dysfunction-in-autism-parental-report-clinical-evaluation-and-associated-factors.html)).


## How To

For input, this code takes in the SPSS-formatted output from a [REDCap](http://www.project-redcap.org) database export.

For output, this code generates a final variable (i.e. `ados_revisclassif_calc` for the revised algorithm) with ASD classifications for each case in the dataset.

This code will calculate a classification based on individual item scores, but also allows for a manual classification (already stored in the database), and will check the two against each other for concordance.

This code expects some variables (i.e. `age_calc_yrs_ados`, etc), which your database may not have; please consider this code as the starting point on which you can build. Most likely, you will need to modify this code to work for your particular dataset.


## License

This is free and unencumbered software released into the public domain. [Full license here](https://github.com/pgorrindo/ADOS-SPSS/blob/master/UNLICENSE). For more information, please refer to [unlicense.org](http://unlicense.org/).

