<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>

<body>
<pre>	<!-- 保留文字原始的編排方式,会保留空格和换行符 -->
<?php
	// $_FILES 可用來取得表單上傳的檔案資料
	// Array
	// (
	//     [file1] => Array
	//         (
	//             [name] => Array
	//                 (
	//                     [0] => 學生帳號密碼.xlsx
	//                     [1] => PHP&MySQL 分組.txt
	//                 )

	//             [type] => Array
	//                 (
	//                     [0] => application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
	//                     [1] => text/plain
	//                 )

	//             [tmp_name] => Array
	//                 (
	//                     [0] => /Applications/MAMP/tmp/php/phphgkx6K
	//                     [1] => /Applications/MAMP/tmp/php/phpq93tOQ
	//                 )

	//             [error] => Array
	//                 (
	//                     [0] => 0
	//                     [1] => 0
	//                 )

	//             [size] => Array
	//                 (
	//                     [0] => 12214
	//                     [1] => 35
	//                 )

	//         )

	//     [file2] => Array
	//         (
	//             [name] => PHP&MySQL課程簡介.pdf
	//             [type] => application/pdf
	//             [tmp_name] => /Applications/MAMP/tmp/php/phpWoUmUO
	//             [error] => 0
	//             [size] => 197062
	//         )
	// )


	// )
	print_r($_FILES);
	echo "<br>";
	echo $_FILES["file1"]["name"][0];
	echo "<br>";
	echo "===================<br>";
	echo $_FILES["file2"]["name"];
	echo "<br>";
	echo "===================<br>";
?>
</pre>
<form action＝"?" method="post" enctype="multipart/form-data">		<!-- action : form 要前往的位置, method : form 要傳遞的方式, enctype : form 編碼格式 -->
	<input type="file" name="file1[]" multiple>	<!-- 設定上傳多個檔案 name : 用陣列[], multiple 屬性  -->
	<br>		<!-- 輸入參數＃1 -->
	<input type="file" name="file2">		<!-- 上傳一個檔案 -->
	<br>
	<input type="submit" name="Upload"><br>
</form>

</body>
</html>