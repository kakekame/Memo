<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
	<form action="?" method="post">
		字串：
		<textarea name="text"></textarea>
		<br>
		要找的字串：
		<input type="text" name="key">
		<br>
		<input type="submit" value="送出">
	</form>
	<pre>
<?php
	$std=explode("\n",$_POST["text"]);

	foreach ($std as $key => $value) {
		if(strchr($value,$_POST["key"])!=false){
			echo $value."\n";
		}
	}
?>
	</pre>
</body>
</html>