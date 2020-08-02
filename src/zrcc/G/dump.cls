Class zrcc.G.dump Extends %Persistent [ Final ]
{

Property Global As %String [ ReadOnly, Required ];

Property Subscript As %String(COLLATION = "EXACT", MAXLEN = "");

Property Value As %String;

/// fill PPG
ClassMethod Global(
	Global As %String = "",
	StartSubscript As %String = "",
	StopSubscript As %String = "") As %Boolean [ SqlName = Dump, SqlProc ]
{
#dim val as %String	= ""
	kill ^||G.dumpD
	set subs=StartSubscript
		,stop=StopSubscript
	set:subs]"" subs="("_subs_")"
	set:stop]"" stop="("_stop_")"
	if subs="" set d=$d(@Global,val)#10 
	else  set d=$d(@(Global_subs),val)#10
	set zr=$ZR
		,Global=$p(zr,"(")
	if d#10 do file
	for  {
		set zr=$q(@zr,1,val) quit:zr=""
		set subs=$p(zr,Global,2,999)
		if stop]"",subs]stop quit
		do file 
		}
	quit $$$OK  

file
	kill ^SPOOL(999999) open 2:999999 use 2 zw val close 2 	
	set val=$e(^SPOOL(999999,1),5,*-2) kill ^SPOOL(999999)
	set val=$replace($replace(val,$c(27)_"[1m",""),$c(27)_"[22m","")	
	set ^||G.dumpD($i(^||G.dumpD))=$lb(Global,subs,val)
	zw val
	quit
}

Storage Default
{
<Data name="dumpDefaultData">
<Value name="1">
<Value>Global</Value>
</Value>
<Value name="2">
<Value>Subscript</Value>
</Value>
<Value name="3">
<Value>Value</Value>
</Value>
</Data>
<DataLocation>^||G.dumpD</DataLocation>
<DefaultData>dumpDefaultData</DefaultData>
<IdLocation>^||dumpD</IdLocation>
<IndexLocation>^||G.dumpI</IndexLocation>
<StreamLocation>^||G.dumpS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
