<?php
// session_start();
	include('../adodb5/adodb.inc.php');	

// define ("SQL_INSCRIPTION","EXECUTE  

	IF ($_POST['function_name'] != '')
	{
		$fn = $_POST['function_name'];
		$fn($_POST['function_params']);
	}
function Connect($sql)
{
	try
	{
	$conn = &ADONewConnection('mysql');
	$conn->Connect("localhost","root","","entre_aide");
	}
	catch (Exception $e)
	{
		die('Erreur : ' . $e->getMessage());
		exit;	
	}
	$result=$conn->Execute($sql);
	return($result);
}

function add_user($params)
{
	$Login=$params['login_php'];
	$Nom=$params['nom_php'];
	$Password=base64_encode($params['password_php']);
	$sql=('select count(id_util) from utilisateur where login like "'.$Login.'";');
	$result=Connect($sql);
	if($result->fields[0]!=0)
	{
		echo 0;
	}
	else
	{
		$sql=('call insert_utilisateur("'.$Login.'","'.$Password.'","'.$Nom.'");');
		Connect($sql);
		$sql=('select max(id_util) from utilisateur');
		$id_util=Connect($sql);
		echo $id_util->fields[0];
	}
}

function form_proposer($params)
{
	$sql=('select * from matiere;');
	$data=Connect($sql);
	$html='<select id="Matiere" name="Matiere" size=5>';
	for($i=0;$i<$data->RecordCount();$i++)
	{
		$html.='<option> '.utf8_encode($data->fields[1]).'</option> ';
		$data->Movenext();
	}
	$html.='</select>';
	$sql=('select * from niveau;');
	$html.='<select id="Niveau" name="Niveau" size=5>';
	$data=Connect($sql);
	for($i=0;$i<$data->RecordCount();$i++)
	{
		$html.='<option> '.utf8_encode($data->fields[1]).'</option> ';
		$data->Movenext();
	}
	$html.='</select>';
	$sql=('select * from specialiter;');
	$html.='<select id="Specialiter" name="Specialiter" size=5>';
	$data=Connect($sql);
	for($i=0;$i<$data->RecordCount();$i++)
	{
		$html.='<option> '.utf8_encode($data->fields[1]).'</option> ';
		$data->Movenext();
	}
	$html.='<select>';
	$html.='</DIV>';
	echo $html;
}

function afficher($params)
{		
	$id=$params['id_util'];
	$sql=('select utilisateur.nom as Eleve, matiere.nom as Matiere,niveau.nom_niv as Niveau_Etude, specialiter.nom as Specialiter, aide.type_aide as Proposition
	from aide inner join matiere
	on aide.id_mat=matiere.id_mat
	inner join  niveau 
	on aide.id_niveau=niveau.id_niveau
	inner join specialiter
	on aide.id_spec=specialiter.id_spec
	inner join utilisateur 
	on aide.id_util=utilisateur.Id_util
	where type_aide like "%Propose%"
	and aide.id_util != '.$id.';');
	$data=Connect($sql);
	$html='<table id=cours_proposer>';
	$html.='<TR><TD>Eleve</TD><TD>Matiere</TD><TD>Niveau etude</TD><TD>Specialiter</TD>';
	if(isset($data->fields[0]))
	{
			for($i=0;$i<$data->RecordCount();$i++)
			{
				$html .='<TR><TD>'.utf8_encode($data->fields[0]).'</TD>';
				$html .='<TD>'.utf8_encode($data->fields[1]).'</TD>';
				$html .='<TD>'.utf8_encode($data->fields[2]).'</TD>';
				$html .='<TD>'.utf8_encode($data->fields[3]).'</TD></TR>';
				$data->Movenext();
			}
	}
	$html.='</table>';
	echo $html;
}
function con_user($params)
{
	$Login=$params['login_php'];
	$pass=$params['password_php'];
	$pass=base64_encode($params['password_php']);
	$sql=('select test("'.$Login.'","'.$pass.'");');
	$result=Connect($sql);
	if(($result->fields[0])!=0)
	{
		$result=Connect('select id_util from utilisateur where Login like "'.$Login.'";');
		echo $result->fields[0];
	}
	else
	{
		echo 0;
	}
}
function proposer($params)
{
	$util=$params['id_util'];
	$mat=$params['mat'];
	$niv=$params['niv'];
	$spec=$params['spec'];
	$sql=('call proposer("'.$util.'","'.$mat.'","'.$niv.'","'.$spec.'");');
	Connect($sql); 
}
