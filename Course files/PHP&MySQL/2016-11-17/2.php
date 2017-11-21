<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
<?php
	$x=10;
	echo $x++;
	echo "<br>";
	echo $x;

	echo "<br>";

	$y=10;
	echo ++$y;
	echo "<br>";
	echo $y;

	echo "<br>==========================<br>";

	$z=100;
	echo $z;
	echo "<br>";

	$z=ABC;
	echo $z;
	echo "<br>";

	$z='單引號：{SCDV$x';
	echo $z;
	echo "<br>";

	$z="雙引號：{SCDV$x\\";
	echo $z;
	echo "<br>";

	echo "<br>==========================<br>";

	$x=array("one"=>"A","two"=>"B","C");
	echo $x["two"];

	echo "<br>";

	$x["two"]="Z";
	echo $x["two"];	//test...
	echo "<br>";

	echo $x[0];
	echo "<br>";

	echo "count=".count($x);
?>
</body>
</html>