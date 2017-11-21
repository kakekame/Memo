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
		$i=1;
		while( $i<=$_POST["count"] ){
			$sum+=$i;
			if($i>=1000){
				break;
			}
			$i++;
		}
		echo $sum;
		echo "<br>";

		$cc=$_POST["count"];
		$i=1;
		while( $i<=$cc ){
			echo "謝謝！";
			if($i>=1000){
				break;
			}
			$i++;
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