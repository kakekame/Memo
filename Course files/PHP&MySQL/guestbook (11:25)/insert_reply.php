<?php
	include("db.php");
	
	$db->prepare("
		insert into `reply`(`source`,`description`,`news_id`) 
		values(:source,:description,:news_id)
	")->execute(
		array_merge($_POST,$_GET)
	);
	
	header("location:".$_SERVER["HTTP_REFERER"]);
?>