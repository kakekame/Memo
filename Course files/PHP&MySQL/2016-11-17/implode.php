<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
	<style>
	span {
		color:#ff0000;
	}
	</style>
</head>
<body>
	<form action="?" method="post">
		生日：
		<input type="number" name="birthday[year]">年
		<input type="number" name="birthday[month]">月
		<input type="number" name="birthday[day]">日
		<br>
		<input type="submit" value="送出">
	</form>
	<pre>
	<?php
		print_r($_POST["birthday"]);
		echo "使用者剛剛輸入的生日：";
		echo implode("-",$_POST["birthday"]);
	?>
	</pre>
</body>
</html>