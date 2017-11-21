<?php
	include("db.php");
	
	//$arr=array_merge($_POST,$_GET);
	
	$db->prepare("
		insert into `news`(`title`,`source`,`time`,`description`) 
		values(:title,:source,:time,:description)
	")->execute($_POST);
	
	header("location:admin.php");
?>