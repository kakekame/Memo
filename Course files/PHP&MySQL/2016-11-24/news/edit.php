<?php
	$currentData=$db->query("
		select * from `news` where `id`='$_GET[id]'
	")->fetch();
?>
<h2>編輯資料</h2>
<form action="update.php?id=<?php echo $_GET["id"]; ?>" method="post" enctype="multipart/form-data">
	標題：<input type="text" name="title" value="<?php echo $currentData["title"]; ?>"><br>
	來源：<input type="text" name="source" value="<?php echo $currentData["source"]; ?>"><br>
	時間：<input type="text" name="time" value="<?php echo $currentData["time"]; ?>"><br>
	內容：<textarea name="description" style="width:300px;height:150px;"><?php echo $currentData["description"]; ?></textarea><br>
	<input type="submit" value="儲存">
</form>