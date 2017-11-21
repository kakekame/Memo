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
<form action="?" method="post">
	<input type="number" name="num1" value="<?php echo $_POST["num1"]; ?>"><br>
	<select name="op">
		<option value="add">加</opton>
		<option value="sub">減</opton>
		<option value="mul">乘</opton>
		<option value="div">除</opton>
	</select><br>
	<script>
		document.querySelector("[name='op']").value="<?php echo $_POST["op"]; ?>";
	</script>
	<input type="number" name="num2" value="<?php echo $_POST["num2"]; ?>"><br>
	<input type="submit" value="計算">
</form>
<?php
	function add($a,$b){
		return $a+$b;
	}
	function sub($a,$b){
		return $a-$b;
	}
	function mul($a,$b){
		return $a*$b;
	}
	function div($a,$b){
		return $a/$b;
	}
	if($_POST["op"]!=""){
		$ret=$_POST["op"]($_POST["num1"],$_POST["num2"]);
		echo "結果：".$ret;
	}
?>
</body>
</html>