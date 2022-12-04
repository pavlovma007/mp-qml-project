#!/usr/bin/perl
#!/usr/bin/perl -d:Trace
# $ sudo cpan install  Devel::Trace

$SOURCE="qml/Korni/Applications/Launcher/";

print("waiting change in $SOURCE \n");

sub buildUpdate
{
	#$side = $[0];
	#$v =  `ghc -c $SOURCE 2>&1 ` ;
	#`./run-1.sh `
	
	system("./run-1.sh  ");
	#return $v
};

while( true )
{ 
	$out=`inotifywait -e modify -r $SOURCE  2>/dev/null ` ; # >/dev/null
	#print($out,"\n");
	
	$v = buildUpdate();
	#print($v)
	
	#if ($v ne  "" ) {
		#print "\n\n\n\n$v" ;
	#} else {
		#$v = `date +%T`;
		#$v =~ s/[\n\r]//g ;
		#print "$v - OK\n" ;
	#}
}
