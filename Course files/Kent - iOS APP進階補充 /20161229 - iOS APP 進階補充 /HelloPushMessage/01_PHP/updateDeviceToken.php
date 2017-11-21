<?php include "./includes/class_session.php";

/*

Test Command: 

curl http://class.softarts.cc/PushMessage/updateDeviceToken.php -v --header 'content-type:application/json' -X POST --data 'data={"UserName":"Tester","DeviceToken":"a1671413bd7d904842754fe2ed571d1b72f97973ffbef3802f452adccdcfe4a8","GroupName":"AP103"}'

*/

//$inputJson = urldecode(file_get_contents("php://input"));
$inputJson = $_POST['data'];

$inputJson=str_replace('data=', '', $inputJson);

if($inputJson=="")
{
	$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT"}';
}
else
{    
//		echo "Input:".$inputJson;

		$inputArray=json_decode($inputJson, true);
	
//		var_dump($inputArray);
	
        $deviceToken = $inputArray['DeviceToken'];
        $userName = $inputArray['UserName'];   
        $groupName = $inputArray['GroupName'];        
        
		if($deviceToken=="")
		{
			$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT_DEVICETOKEN"}';
		} 
		else if($userName=="")
		{
			$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT_USERNAME"}';
		}     
		else if($groupName=="")
		{
			$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT_GROUPNAME"}';
		} 		       
		else 
		{                         
			// Check if the record is exist already.
			$sql = "select * from DeviceTokenList where UserName='$userName' and GroupName='$groupName'";
			$res = $db->sql_query($sql);
			$row = $db->sql_fetchrow($res);
		
			if($row['id'] != ''){
				$sql = "update DeviceTokenList set
				DeviceToken = '$deviceToken',
				UserName = '$userName',            
				LastUpdateDateTime = now()
				where UserName='$userName' and GroupName='$groupName'";
			}else{
				$sql = "insert into DeviceTokenList (UserName,DeviceToken,LastUpdateDateTime,GroupName) values (   
				'$userName',              
				'$deviceToken',
				now(),            
				'$groupName'
				)";
			}
	//        echo $sql;
		
			if($db->sql_query($sql)){
				$rtn = '{"result" : true}';
			}else{
				$rtn = '{"result" : false,"errorCode":"ERR_SQL_CMD"}';
			}		
		}
}

echo $rtn;

?>