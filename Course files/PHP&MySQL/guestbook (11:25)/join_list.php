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
		foreach ($_SESSION["join"] as $key => $value) {
			if($value==0){
				continue;
			}
			$data=$db->query("select * from `news` where `id`='$key'")->fetch();
	?>
		<tr>
			<td><?php echo $data["title"]; ?></td>
			<td><?php echo $data["source"]; ?></td>
			<td><?php echo $data["time"]; ?></td>
			<td>
				<a href="join_delete.php?id=<?php echo $data["id"]; ?>">刪除</a>
			</td>
		</tr>
	<?php
		}
	?>
	</tbody>
</table>
<a href="">確定購買</a>