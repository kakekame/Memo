<?php include "./includes/class_session.php";
    include "./includes/apns_function.php";
//error_reporting(E_ALL);
//ini_set('display_errors', True);

/*

Test Command: 

curl http://class.softarts.cc/PushMessage/sendPhotoMessage.php -v --header 'content-type:application/json' -X POST --data 'data={"UserName":"tester","GroupName":"AP101"}'
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
    $groupName = $inputArray['GroupName'];    

	if($username == "")
	{
		$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT_USERNAME"}';
	}     
	else if($groupName == "")
	{
		$rtn = '{"result" : false,"errorCode":"ERR_NO_INPUT_GROUPNAME"}';
	} 			
	else
	{
	
		$randomPhotoID = md5(rand() * time());
		$target_dir = "/PushMessage/photos/";
		$target_filename = $groupName. "_" . $randomPhotoID. "_" .basename($_FILES["fileToUpload"]["name"]);
		$target_filepath = $_SERVER['DOCUMENT_ROOT']  .$target_dir . $target_filename;

		if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_filepath)) {
		//	echo "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded as ".$target_filename.".";
			// Type 1 mean image
			$sql = "insert into ChatMessages (UserName,Type,Message,GroupName,LastUpdateDateTime) values (
			'$username',
			1,            
			'$target_filename',
			'$groupName',
			now()
			)";

		//        echo $sql;

			$badge = 88;
			$sound = 'bell.mp3';

			// Push to all users except sender.
			doPushToAll($db,$username." send a photo.",$badge,$sound,'PushMessage.pem',$username,$groupName);	

			if($db->sql_query($sql)){
				$rtn = '{"result" : true}';
	
			}else{
				$rtn = '{"result" : false,"errorCode":"ERR_SQL_CMD"}';
			}	

		} else {
			$rtn = '{"result" : false,"errorCode":"ERR_MOVE_UPLOAD_FILE"}';
		}	

	}

	echo $rtn;
	
}
else
{
	echo '{"result": false,"errorCode":"ERR_NO_INPUT" }';
}







?> 