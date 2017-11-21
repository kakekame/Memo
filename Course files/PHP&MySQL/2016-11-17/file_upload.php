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
	<form action="?" method="post" enctype="multipart/form-data">
		<input type="file" name="ff">
		<input type="submit" value="上傳">
	</form>
<?php
	if(count($_FILES)>0){
		copy($_FILES["ff"]["tmp_name"],"file_upload/".$_FILES["ff"]["name"]);
	}
?>
</body>
</html>