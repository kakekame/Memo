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
		.box .top .left {
			float: left;
		}
		.box .top .right {
			float: right;
		}
		.box .top .clear {
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