<?php
	include("db.php");
	
	$_SESSION["join"][$_GET["id"]]=0;

	$_SESSION["info"]="刪除成功！";
	
	header("location:admin.php?action=join_list");
?>