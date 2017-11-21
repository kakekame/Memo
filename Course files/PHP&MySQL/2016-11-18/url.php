<?php
	session_start();
?>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
<?php
	$x="aa&bb&cc";
	print_r($_GET);
?>
<a href="?q=<?php echo urlencode($x); ?>">[連結]</a>
</body>
</html>