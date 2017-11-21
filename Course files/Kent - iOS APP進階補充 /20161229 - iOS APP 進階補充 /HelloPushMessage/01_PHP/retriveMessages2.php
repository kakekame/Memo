<?php include "./includes/class_session.php";

/*

Test Command: 

curl http://class.softarts.cc/PushMessage/retriveMessages2.php -v --header 'content-type:application/json' -X POST --data 'data={"GroupName":"AP103","LastMessageID":123}'


*/

//$inputJson = urldecode(file_get_contents("php://input"));
$inputJson = $_POST['data'];

$inputJson=str_replace('data=', '', $inputJson);

if($inputJson!="")
{
//	echo "Input:".$inputJson;

	$inputArray=json_decode($inputJson, true);

    $groupName = $inputArray['GroupName'];  
    $lastMessageID = $inputArray['LastMessageID'];      
    
	if($lastMessageID=="")
	{
		$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT_LASTMESSAGEID"}';
	}  
	else if($groupName=="")
	{
		$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT_GROUPNAME"}';
	} 		  
	else 
	{
	//  and id > $lastMessageID
		$sql = "select * from ChatMessages where GroupName='$groupName' and id > $lastMessageID order by LastUpdateDateTime ASC";
		$res = $db->sql_query($sql);
		$num = $db->sql_numrows($res);
	
		if($num > 0) 
		{
			$rtnTemp = array("result" => true,"Messages" => array());
	
			while($row = $db->sql_fetchrow($res)) {
			
				$itemTmp = array(
								 "id"=>$row['id'],
								 "UserName"=>$row['UserName'],		
								 "Type"=>$row['Type'],							 							 					 
								 "Message"=>$row['Message']
								 );
				array_push($rtnTemp["Messages"], $itemTmp);
			}
		}
		else
		{
			$rtnTemp = array("result" => true);    
		}
			
		$rtn = json_encode($rtnTemp,JSON_NUMERIC_CHECK);	
	}  

    echo $rtn;
}
else
{
	echo '{"result": false,"errorCode":"ERR_NO_INPUT" }';
}


?>