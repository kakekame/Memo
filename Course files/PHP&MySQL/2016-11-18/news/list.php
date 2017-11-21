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
		foreach ($db->query("select * from `news`") as $key => $value) {
	?>
		<tr>
			<td><?php echo $value["title"]; ?></td>
			<td><?php echo $value["source"]; ?></td>
			<td><?php echo $value["time"]; ?></td>
			<td>
				<a href="">編輯</a>
				<a href="delete.php?id=<?php echo $value["id"]; ?>">刪除</a>
			</td>
		</tr>
	<?php
		}
	?>
	</tbody>
</table>