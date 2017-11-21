<?php
	include("db.php");
	
	$_SESSION["users"]="";
	$_SESSION["info"]="登出成功！";
	
	header("location:admin.php");
?>