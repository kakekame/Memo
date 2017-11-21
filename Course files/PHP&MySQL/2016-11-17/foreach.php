<?php
	error_reporting(0);
?>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
<pre>
<?php
	$variable=array(
		"AAAA",
		"apple"=>"BBBB",
		"CCCC",
		"DDDD"
	);
	foreach ($variable as $key => &$value) {
		$value="**".$value;
		echo $key."=>".$value."<br>";
	}
	print_r($variable);
?>
</pre>
<form action="?" method="post">
	<input type="number" name="count"><br>
	<input type="submit" value="送出">
</form>

</body>
</html>