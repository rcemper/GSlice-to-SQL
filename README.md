Globals in Caché / Ensemble / IRIS are normally invisible over SQL access   
This example shows how to overcome this limit.   
Globals are presented as content of a table with their subscripts and  
the stored content.  
The global to view is passed to SQL by a static WHERE condition that  
requires 3 parameters:   
- the global name (required)   
- the start subscript (optional)    
- the stop subscript (optional)   

Just providing the global name results in a full global dump.    
Globals may also be provided with the extended reference   
and as this is a table all kind of additional conditions apply. 

Be careful. 
Correct quoting between SQL and Caché / Ensemble / IRIS could be a challenge

Example:   
__select * from zrcc_G.dump where zrcc_G.Dump('^|"SAMPLES"|Sample.PersonD',2,4)=1__
~~~
ID	       Global	        Subscript	      Value
1	^|"SAMPLES"|Sample.PersonD	(2)	$lb("",792533244,"GlobaDynamics Holdings Inc.",64256,"C1787","Y5365","A5","A658","R1770","","Ironhorse,Alice D.","T3710","O3","I4011","W8367","557-37-6758",83059958205089661,"1841-01-02 00:00:00")
2	^|"SAMPLES"|Sample.PersonD	(3)	$lb("",862705606,"TeleLateral Associates",34553,"V8155","T8918","X9","V8732","K1167","","Eisenstien,Peter E.","H208","C8","Q2015","Q3357","702-46-8467",57275722714358892,"2020-06-23 13:27:18")
3	^|"SAMPLES"|Sample.PersonD	(4)	$lb("",677194559,"RoboSoft Group Ltd.",52738,"F4851","Z364","S8","O6888","O4367","","Eagleman,Clint C.","C8051","R6","V1659","C9814","664-33-8809",-53705244349891319,"2020-06-23 13:27:18")
~~~

It's obvious for COS-experts. Anyhow: This example fails if you don't have an installation of SAMPLES namespace at hands.

__select TOP 15 * from zrcc_G.dump where zrcc_G.Dump('^%SYS','"JOURNAL"')=1__   
~~~
ID	Global	       Subscript	         Value
1	^%SYS	("JOURNAL")	           0
2	^%SYS	("JOURNAL","ALTDIR")   "C:\InterSystems\IRIS\altjournal\"
3	^%SYS	("JOURNAL","CURDIR")   "C:\InterSystems\IRIS\mgr\journal\"
4	^%SYS	("JOURNAL","CURRENT")  "1^C:\InterSystems\IRIS\mgr\journal\20200801.009"
5	^%SYS	("JOURNAL","EXPSIZE")  0
6	^%SYS	("JOURNAL","LAST")     "1^C:\InterSystems\IRIS\mgr\journal\20200801.009"
7	^%SYS	("JOURNAL","LIFESPAN","FILE")	"2,2"
8	^%SYS	("JOURNAL","MAXSIZE")	 1073741824
9	^%SYS	("JOURNAL","PREFIX")   ""
10	^%SYS	("JOURNAL","PURGED","c:\intersystems\iris\mgr\journal\20191104.001")	"2019-11-07 17:38:30"
11	^%SYS	("JOURNAL","PURGED","c:\intersystems\iris\mgr\journal\20191104.002")	"2019-11-07 17:38:30"
12	^%SYS	("JOURNAL","PURGED","c:\intersystems\iris\mgr\journal\20191104.003")	"2019-11-07 17:38:30"
13	^%SYS	("JOURNAL","PURGED","c:\intersystems\iris\mgr\journal\20191104.004")	"2019-11-07 17:38:30"
14	^%SYS	("JOURNAL","PURGED","c:\intersystems\iris\mgr\journal\20191104.005")	"2019-11-08 08:39:47"
15	^%SYS	("JOURNAL","PURGED","c:\intersystems\iris\mgr\journal\20191105.001")	"2019-11-08 08:39:47"
~~~

[Article in DC](https://community.intersystems.com/post/show-global-sql-select)   
