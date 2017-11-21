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
	<?php
		if($_POST["op"]!=""){
			$obj=new cal($_POST["num1"],$_POST["num2"]);
			$ret=$obj->$_POST["op"]();
			echo "結果：".$ret;
		}
	?>
</form>
</body>
</html>