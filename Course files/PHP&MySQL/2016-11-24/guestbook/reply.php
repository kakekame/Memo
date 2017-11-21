<h2>新增回覆</h2>
<form action="insert_reply.php?news_id=<?php echo $_GET["id"]; ?>" method="post" enctype="multipart/form-data">
	來源：<input type="text" name="source"><br>
	內容：<textarea name="description" style="width:300px;height:150px;"></textarea><br>
	<input type="submit" value="儲存">
</form>
<?php
	foreach ($db->query("
		select `reply`.* , `news`.`title` , 
		`news`.`description` as `news_description` , `news`.`source` as `news_source` from 
		`news` inner join `reply` 
		on `news`.`id`=`reply`.`news_id` where `news`.`id`='$_GET[id]'
	") as $key => $value) {
		if($key==0){
?>
	<div>
		標題：<?php echo $value["title"]; ?><br>
		來源：<?php echo $value["news_source"]; ?><br>
		內容：<?php echo $value["news_description"]; ?><br>
	</div><br>
<?php
		}
?>
	<div><?php echo $value["source"]; ?>：<?php echo $value["description"]; ?></div>
<?php
	}
?>