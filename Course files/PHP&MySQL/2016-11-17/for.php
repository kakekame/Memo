<?php
	error_reporting(0);
?>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>
<pre>
<?php
	if($_POST["count"]>=1){
		for( $i=1 ; $i<=$_POST["count"] ; $i++ ){
			$sum+=$i;
			if($i>=1000){
				break;
			}
		}
		echo $sum;
		echo "<br>";

		$cc=$_POST["count"];
		for( $i=1 ; $i<=$cc ; $i++ ){
			echo "謝謝！";
			if($i>=1000){
				break;
			}
		}
		echo "\n很重要所以重複 $cc 次";
	}else{
		echo "請輸入大於等於零的數值！";
	}
?>
</pre>
<form action="?" method="post">
	<input type="number" name="count"><br>
	<input type="submit" value="送出">
</form>

</body>
</html>