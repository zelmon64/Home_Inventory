<?php
	
	require_once('environment.php');
	checkAuth($_SERVER['PHP_SELF'] . '?' . $_SERVER['QUERY_STRING']);
		
	//print_r($_REQUEST);
	$bModify = isset($_REQUEST['id']) && is_numeric($_REQUEST['id']);

	
	// save pictures
	if ($_REQUEST['action'] == 'save')
	{
		for ($i = 1; $i <= 4; $i++)
		{
			if ($_FILES["file$i"]['size'] <= 0)
				continue;
				
			$sPict = uploadImage("file$i", $sError);
			if (!$sPict && !empty($sError)) 
				die($sError);
			elseif (!$sPict)
				$sPict = '';
				
			$sSql = 'INSERT INTO Picture(PCT_ItemId, PCT_FileName) ' .
						"VALUES({$_REQUEST['id']}, '$sPict')";
			$result = mysqli_query($GLOBALS['link'], $sSql) or die('Query failed: ' . mysqli_error($GLOBALS['link']));
		}
	}
	elseif ($_REQUEST['action'] == 'deletePicture' && is_numeric($_REQUEST['pictId']))
	{
		$sSql = "DELETE FROM Picture WHERE PCT_ID = {$_REQUEST['pictId']}";
		$result = mysqli_query($GLOBALS['link'], $sSql) or die('Query failed: ' . mysqli_error($GLOBALS['link']));
		// delete file on disk
		@unlink(SITE_PATH . 'htdocs/images/items/' .$_REQUEST['pictFileName']);
	}
	
	
	$sSql = 'SELECT ITM_ShortName ' .
			'  FROM Item ' .
			' WHERE ITM_ID = ' . $_REQUEST['id'];
	$aItem = fetchFromDb($sSql, true);

	$sHtml = makePictureGallery($_REQUEST['id']);
	
	//print_r($aPicture);
	$GLOBALS["hSmarty"]->assign('SHOW_EDIT_PICTURE', true);
	$GLOBALS["hSmarty"]->assign('HTML_PICTURES', $sHtml);
	$GLOBALS["hSmarty"]->assign('ITEM_INFO', $aItem);
	$GLOBALS['hSmarty']->display('_main.tpl');



	
?>