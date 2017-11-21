<a href="?action=add">新增</a>
<?php if(count($_SESSION["join"])>0){ ?>
<a href="?action=join_list">前往購買清單</a>
<?php } ?>
	<?php
		if($_GET["page"]==""){
			$_GET["page"]=1;
		}
		$sp=($_GET["page"]-1)*3;
		foreach ($db->query("select * from `news` order by `time` desc,`id` asc limit $sp,3") as $key => $value) {
	?>
		<div class="box">
			<div class="top">
				<div class="left"><?php echo $value["source"]; ?></div>
				<div class="right"><?php echo $value["time"]; ?></div>
				<div class="clear"></div>
			</div>
			<div class="middle">
				<div class="title">
					<a href="?action=reply&id=<?php echo $value["id"]; ?>">
						<?php echo $value["title"]; ?>
					</a>
				</div>
				<div class="description"><?php echo $value["description"]; ?></div>
			</div>
			<div class="bottom">
				<div class="left">
					<a href="?action=edit&id=<?php echo $value["id"]; ?>">編輯</a>
					<a href="delete.php?id=<?php echo $value["id"]; ?>">刪除</a>
				</div>
				<div class="right">
					<a href="join.php?id=<?php echo $value["id"]; ?>">加入購買清單</a>
				</div>
				<div class="clear"></div>
			</div>
		</div>
	<?php
		}
	?>

<div class="footer">
	<div>
		總共有<?php echo $db->query("select count(`id`) from `news`")->fetchColumn(0); ?>筆資料
	</div>
	<div>
		<?php
			$pageCount=ceil($db->query("select count(`id`) from `news`")->fetchColumn(0)/3);
			for($p=1;$p<=$pageCount;$p++){
				echo '<a href="?page='.$p.'">'.$p.'</a> ';
			}
		?>
	</div>
</div>