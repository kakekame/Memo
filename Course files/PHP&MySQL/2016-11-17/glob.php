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
	if($_POST["dirname"]!=""){
		mkdir($_GET["path"]."/".$_POST["dirname"]);
	}
	if($_GET["del_dirname"]!=""){
		rmdir($_GET["del_dirname"]);
	}
	foreach(glob($_GET["path"]."/*") as $key => $value) {
		if(is_dir($value)==true){
			echo "<a href='?path=".$value."'>".$value."</a>";
			echo "<a href='?del_dirname=".$value."'>(Delete)</a>";
			echo "<br>";
		}else{
			echo $value."<br>";
		}
	}
?>
</body>
</html>