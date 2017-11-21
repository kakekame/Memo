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
		<input type="file" name="ff[]" multiple>
		<input type="submit" value="上傳">
	</form>
<?php
	if($_GET["action"]=="delete"){
		$ff=explode("\n",file_get_contents("file_upload2.txt"));
		$ff[$_GET["id"]]="";
		file_put_contents("file_upload2.txt", implode("\n",$ff));
		$_GET["id"]++;
		unlink("file_upload2/".$_GET["id"]);
	}
	if(count($_FILES)>0){
		foreach ($_FILES["ff"]["tmp_name"] as $key => $value) {
			file_put_contents("file_upload2.txt", $_FILES["ff"]["name"][$key]."\n", 8);

			$ff=explode("\n",file_get_contents("file_upload2.txt"));

			copy($_FILES["ff"]["tmp_name"][$key],"file_upload2/".(count($ff)-1));
		}
	}
	$ff=explode("\n",file_get_contents("file_upload2.txt"));
	foreach ($ff as $key => $value) {
		if($value!=""){
			echo $value;
			echo '<a href="?action=delete&id='.$key.'">[Delete]</a><br>';
		}
	}
?>
</body>
</html>