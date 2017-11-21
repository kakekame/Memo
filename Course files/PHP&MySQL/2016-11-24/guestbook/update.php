<?php
	include("db.php");
	
	//$arr=array_merge($_POST,$_GET);
	
	$db->prepare("
		update `news` set 
		`title`=:title,`source`=:source,`time`=:time,`description`=:description 
		where `id`=:id
	")->execute(
		array_merge($_POST,$_GET)
	);
	
	header("location:admin.php");
?>