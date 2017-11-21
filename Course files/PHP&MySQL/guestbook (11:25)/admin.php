<?php
	include("db.php");
?>
<html>
	<head>
		<title></title>
		<meta charset="utf-8">
		<style>
		.tableStyle1 {
			border-collapse: collapse;
			width: 100%;
		}
		.tableStyle1 th, .tableStyle1 td {
			border: 1px solid #666666;
			padding: 5px;
		}
		.tableStyle1 th {
			background: #666666;
			color:#ffffff;
		}
		a {
			display: inline-block;
			background: #333333;
			border-radius: 5px;
			padding: 3px 5px;
			color:#ffffff;
			text-decoration: none;
		}
		body {
			text-align: center;
		}
		.box {
			width:300px;
			margin: 10px auto;
			background: #aaaacc;
			padding: 10px;
			text-align: left;
		}
		.box .top {
			background: #ffffff;
			padding: 3px;
			margin: 0 0 10px 0;
		}
		.box .left {
			float: left;
		}
		.box .right {
			float: right;
		}
		.box .clear {
			clear: both;
		}
		.box .middle {
			background: #ffffff;
			padding: 3px;
			margin: 0 0 10px 0;
		}
		.box .middle .title {
			border-bottom:1px solid #999999;
			padding: 3px;
		}
		.box .middle .description {
			padding: 3px;
		}
		.footer {
			text-align: center;
		}
		.footer div {
			margin: 5px;
		}
		</style>
		<?php
			if($_SESSION["info"]!=""){
		?>
		<script>
			window.alert("<?php echo $_SESSION["info"]; ?>");
		</script>
		<?php
				$_SESSION["info"]="";
			}
		?>
	</head>
	<body>
	<?php
		if($_SESSION["users"]!=""){
			if($_GET["action"]==""){
				$_GET["action"]="list";
			}
	?>
	<div style="text-align:right;">
		您好，<?php echo $_SESSION["users"]["username"]; ?>！ 
		<a href="logout.php">登出</a>
	</div>
	<?php
			include($_GET["action"].".php");
		}else{
	?>
		<form action="login.php" method="post">
			<label>帳號：</label><input type="text" name="username"><br>
			<label>密碼：</label><input type="password" name="password"><br>
			<input type="submit" value="登入">
		</form>
	<?php
		}
	?>
	</body>
</html>