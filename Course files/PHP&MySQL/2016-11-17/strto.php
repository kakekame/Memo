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
		字串：
		<input type="text" name="text">
		<br>
		<input type="submit" value="送出">
	</form>
	<pre>
<?php
	echo "小寫：".strtolower($_POST["text"]);
	echo "<br>";
	echo "大寫：".strtoupper($_POST["text"]);
?>
	</pre>
</body>
</html>