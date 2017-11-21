<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
<?php
	print_r($_POST);
?>
<br>
	<form action="?" method="post">
		Username:<input type="text" name="user"><br>
		Password:<input type="password" name="pwd"><br>
		Birthday:<input type="date" name="birth"><br>
		<input type="submit" value="Send"><br>
	</form>
<br>=========================<br>
<?php
	echo $_POST["num1"]."+".$_POST["num2"];
	echo "=".($_POST["num1"]+$_POST["num2"]);
?>
	<form action="?" method="post">
		<input type="number" name="num1">
		+
		<input type="number" name="num2">
		<input type="submit" value="="><br>
	</form>
</body>
</html>