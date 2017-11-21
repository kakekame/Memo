<a href="?action=add">新增</a>
<table class="tableStyle1">
	<thead>
		<tr>
			<th>標題</th>
			<th>來源</th>
			<th>時間</th>
			<th>管理</th>
		</tr>
	</thead>
	<tbody>
	<?php
		if($_GET["page"]==""){
			$_GET["page"]=1;
		}
		$sp=($_GET["page"]-1)*3;
		foreach ($db->query("select * from `news` order by `time` desc,`id` asc limit $sp,3") as $key => $value) {
	?>
		<tr>
			<td><?php echo $value["title"]; ?></td>
			<td><?php echo $value["source"]; ?></td>
			<td><?php echo $value["time"]; ?></td>
			<td>
				<a href="?action=edit&id=<?php echo $value["id"]; ?>">編輯</a>
				<a href="delete.php?id=<?php echo $value["id"]; ?>">刪除</a>
			</td>
		</tr>
	<?php
		}
	?>
	</tbody>
</table>
<div>
	<div style="float:left;">
		總共有<?php echo $db->query("select count(`id`) from `news`")->fetchColumn(0); ?>筆資料
	</div>
	<div style="float:right;">
		<?php
			$pageCount=ceil($db->query("select count(`id`) from `news`")->fetchColumn(0)/3);
			for($p=1;$p<=$pageCount;$p++){
				echo '<a href="?page='.$p.'">'.$p.'</a> ';
			}
		?>
	</div>
	<div style="clear:both;"></div>
</div>