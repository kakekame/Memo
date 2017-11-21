<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
	<style>
	.content {
		border:1px solid #666666;
		border-radius: 10px;
		padding:30px;
		margin: 20px 10px 10px 10px;
		min-height: 200px;
	}
	</style>
</head>
<body>
	<a href="?page=home">HOME</a> | 
	<a href="?page=about">ABOUT</a> | 
	<a href="?page=contact">CONTACT</a>
	<div class="content">
		<?php require_once($_GET["page"].".php"); ?>
		<?php require_once($_GET["page"].".php"); ?>
		<?php require_once($_GET["page"].".php"); ?>
	</div>
	copyright &copy;
</body>
</html>