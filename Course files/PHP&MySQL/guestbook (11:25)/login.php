<?php
	include("db.php");
	
	$userInfo=$db->query("
		select * from `users` where `username`='$_POST[username]' and `password`='$_POST[password]'
	")->fetch();

	if($userInfo!=""){
		$_SESSION["users"]=$userInfo;
		$_SESSION["info"]="登入成功！";
	}else{
		$_SESSION["info"]="登入失敗，帳號或密碼錯誤！";
	}
	
	header("location:admin.php");
?>