# Assignment-1-gmarimu1

--------------
Optimization:
--------------
TO speed up the upload, I'm using the pgbulkload method.

This optimization resulted in upload time ranges from 95-100 secs. 
While runing the pgbulkload it is generating .ctl file, I've attached that file as well for safe side.

-----------
For query 4
-----------
I tried using both having and where, below are the result
having - 3.7 sec
where - 2.2 sec
So, "where" is faster, this is because it filters rows before doing the calculations but "having" is doing the calculation after grouping.
I cleared both Postgres and OS cache before comparing the speed.
