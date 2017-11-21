<?php
	include("db.php");
	$db->query("delete from `news` where `id`='$_GET[id]'");
	header("location:admin.php");
?>