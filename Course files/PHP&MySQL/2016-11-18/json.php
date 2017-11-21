<?php
	session_start();
?>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
	<form action="?path=<?php echo $_GET["path"]; ?>" method="post" enctype="multipart/form-data">
		建立資料夾：<input type="text" name="dirname">
		<input type="submit" value="建立">
	</form>
<?php
	$arr=array("x"=>"aa","y"=>"bb","z"=>"cc");
	echo json_encode($arr);
	echo "<br>";
	print_r(json_decode('{"x":"aa","y":"bb","z":"cc"}',1));
?>
</body>
</html>