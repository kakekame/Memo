<html>
	<head>
		<title></title>
		<meta charset="utf-8">
	</head>
	<body>
<pre>
<?php
	$db=new pdo("mysql:host=localhost;port=8889","root","root");
	$db->query("set names 'utf8'");
	$db->query("use `test_2016-11`");

	//$d=$db->query("select * from `news`")->fetchAll();
	//print_r($d);
	
	foreach ($db->query("select * from `news`") as $key => $value) {
		echo $key."\n";
		echo "標題：".$value["title"]."\n";
		echo "來源：".$value["source"]."\n";
		echo "時間：".$value["time"]."\n";
		echo "摘要：".$value["description"]."\n\n\n";
	}
?>
</pre>
	</body>
</html>