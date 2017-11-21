<?php
	include("db.php");
	
	$_SESSION["join"][$_GET["id"]]=1;

	$_SESSION["info"]="加入成功！";
	
	header("location:admin.php");
?>