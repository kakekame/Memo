<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
<pre>
<?php
	print_r($_FILES);
	echo $_FILES["yy"]["name"];
?>
</pre>
	<form action="?" method="post" enctype="multipart/form-data">
		<input type="file" name="xx[]" multiple><br>
		<input type="file" name="yy"><br>
		<input type="submit" value="Upload"><br>
	</form>
</body>
</html>