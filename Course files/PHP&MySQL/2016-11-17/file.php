<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
	<form action="?" method="post">
		檔案名稱：
		<input type="text" name="fn">
		<br>
		要儲存的內容：
		<textarea name="text"></textarea>
		<br>
		<input type="submit" value="送出">
	</form>
	<img src="file_image.php">
	<pre>
<?php
	if($_POST["fn"]!=""){
		file_put_contents($_POST["fn"], $_POST["text"],8);
	}
?>
	</pre>
</body>
</html>