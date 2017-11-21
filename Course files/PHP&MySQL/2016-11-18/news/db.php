<?php
	$db=new pdo("mysql:host=localhost;port=8889","root","root");
	$db->query("set names 'utf8'");
	$db->query("use `test_2016-11`");
?>