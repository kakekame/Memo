<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
	<style>
	span {
		color:#ff0000;
	}
	#box1 {
		display: none;
	}
	</style>
	<script>
	function change_box(){
		document.querySelector("#box1").style.display="block";
		document.querySelector("#box2").style.display="none";
	}
	</script>
</head>
<body>
	<form action="?" method="post">
		字串：
		<input type="text" name="text">
		<br>
		<input type="submit" value="送出">
	</form>
	<pre>
<?php
	echo "<div id='box1'>".$_POST["text"]."</div>";
	echo "<div id='box2'>".mb_strimwidth($_POST["text"], 0, 57,"...<a href='javascript:change_box()'>(More)</a>","UTF-8")."</div>";
?>
	</pre>
</body>
</html>