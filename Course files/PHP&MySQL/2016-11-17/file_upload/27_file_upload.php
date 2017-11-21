<?php 
	session_start();
 ?>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>strchr</title>
	
</head>
<body>
	<form action="" method="post" enctype="multipart/form-data">
		<input type="file" name="ff">
		<input type="submit" value="上傳">
	</form>
<pre>
<?php 
	if (count($_FILES)>0) {
		print_r($_FILES["ff"]);
		copy($_FILES["ff"]["tmp_name"], "file_upload/".$_FILES["ff"]["name"]);
		//$_FILES["ff"]是一個陣列
// 		Array
// 		(
//     		[name] => 5_FILES.php //檔案名稱
//     		[type] => text/php    //檔案格式
//     		[tmp_name] => /Applications/MAMP/tmp/php/phpgeb6rr  //暫存路徑
//     		[error] => 0   
//     		[size] => 745  //大小
// 		)
	}

?>
</pre>
	
</body>
</html>