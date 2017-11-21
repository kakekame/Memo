<?php include "./includes/class_session.php";
    include "./includes/apns_function.php";

/*

Test Command: 

curl http://class.softarts.cc/PushMessage/sendMessage.php -v --header 'content-type:application/json' -X POST --data 'data={"UserName":"tester","Message":"aaaa","GroupName":"AP101"}'
*/

//$inputJson = urldecode(file_get_contents("php://input"));
$inputJson = $_POST['data'];

$inputJson=str_replace('data=', '', $inputJson);

if($inputJson!="")
{
//	echo "Input:".$inputJson;

	$inputArray=json_decode($inputJson, true);
	
//	var_dump($inputArray);
	
	$username=$inputArray['UserName'];
	$message=$inputArray['Message'];	
    $groupName = $inputArray['GroupName'];    
	
	if($message=="")
	{
		$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT_MESSAGE"}';
	} 
	else if($username=="")
	{
		$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT_USERNAME"}';
	}     
	else if($groupName=="")
	{
		$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT_GROUPNAME"}';
	} 			
	else 
	{
		// Type 0 mean text
		$sql = "insert into ChatMessages (UserName,Type,Message,GroupName,LastUpdateDateTime) values (
		'$username',
		0,            
		'$message',
		'$groupName',
		now()
		)";

	//        echo $sql;

		$badge = 88;
		$sound = 'bell.mp3';

		// Push to all users except sender.
		doPushToAll($db,$message,$badge,$sound,'PushMessage.pem',$username,$groupName);	

		if($db->sql_query($sql)){
			$rtn = '{"result" : true}';
		
		}else{
			$rtn = '{"result" : false,"errorCode":"ERR_SQL_CMD"}';
		}	
	}

	echo $rtn;
	
}
else
{
	echo '{"result": false,"errorCode":"ERR_NO_INPUT" }';
}




?>