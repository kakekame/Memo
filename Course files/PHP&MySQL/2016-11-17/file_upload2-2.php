<?php
	session_start();
?>
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title></title>
	<style>
		.box {
			float:left;
			width:200px;
			margin:10px;
		}
		.box .image {
			height:200px;
			background: #ff0000 no-repeat center; /* center top bottom left right */
			background-size: cover;

		}
	</style>
</head>
<body>
	<form action="?" method="post" enctype="multipart/form-data">
		<input type="file" name="ff[]" multiple>
		<input type="submit" value="上傳">
	</form>
<?php
	//刪除的操作
	if($_GET["action"]=="delete"){
		$ff=explode("\n",file_get_contents("file_upload2.txt"));	//讀取當前的檔案列表並將它切格成陣列
		$ff[$_GET["id"]]="";										//清除要刪除的那個檔案資訊
		file_put_contents("file_upload2.txt", implode("\n",$ff));	//將結果陣列組成字串存回去

		$_GET["id"]++;												//因為實體的檔案編號會比陣列的多1，所以要加1
		unlink("file_upload2/".$_GET["id"]);						//刪除檔案
	}

	//檔案上傳時的操作
	if(count($_FILES)>0){																//判斷有沒有上傳資料
		foreach ($_FILES["ff"]["tmp_name"] as $key => $value) {							//迴圈讀取所有上傳的檔案資料
			file_put_contents("file_upload2.txt", $_FILES["ff"]["name"][$key]."\n", 8);	//將當前迴圈讀取到的檔案名稱存txt檔中

			$ff=explode("\n",file_get_contents("file_upload2.txt"));
			//將txt檔讀出並依列切割成陣列

			copy($_FILES["ff"]["tmp_name"][$key],"file_upload2/".(count($ff)-1));
			//將迴圈當前讀到的檔案複製到指定位址，並計算txt檔中的列數作為檔名
		}
	}

	//列出當前檔案
	$ff=explode("\n",file_get_contents("file_upload2.txt"));
	//將txt檔讀出並依列切割成陣列

	foreach ($ff as $key => $value) {	//迴圈讀取txt檔中的每列資料
		if($value!=""){					//只顯示有資料的列
?>
			<div class="box">
				<div class="image" style="background-image:url('file_upload2/<?php echo $key+1; ?>');"></div>
				<a href="?action=delete&id=<?php echo $key; ?>">[Delete]</a><br>
			</div>
<?php
		}
	}
?>
</body>
</html>