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
	echo "當前位址：".$_GET["path"]."<br>";
	echo "<a href='?path=".dirname($_GET["path"])."'>回上一頁</a> ";
	echo "<br>";
	foreach(glob($_GET["path"]."/*") as $key => $value) {
		if(is_dir($value)==true){
			echo "<a href='?path=".$value."'>".basename($value)."</a> ";
			echo "<a href='?del_dirname=".$value."'>(Delete)</a>";
			echo "<br>";
		}else{
			echo $value."<br>";
		}
	}
?>
</body>
</html>