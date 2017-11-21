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
		</style>
	</head>
	<body>
	<?php
		if($_GET["action"]==""){
			$_GET["action"]="list";
		}
		include($_GET["action"].".php");
	?>
	</body>
</html>