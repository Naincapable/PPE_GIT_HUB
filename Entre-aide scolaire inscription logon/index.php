<html>
	<!doctype html>
	<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		<LINK rel="stylesheet" type="text/css" href="style.css" />
		<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/smoothness/jquery-ui.css" />
		<title>entraide-scolaire : Accueil</title>
	</head>
	<body>	
		<input type=button id="inscription" value="inscription"></input>
		<input type=button id="connexion" value="connexion"></input>
		<div id="login">
				<div>Login</div>
				<input type=text id="L_Login"></input>
				<div>Mot de passe</div>
				<input type=password id="L_MotDePasse"></input>
				<input type=button id="L_valider" value="valider"></input>
		</div>
		<div id="form">
			<!--<form method="post" action="fonction.php" >-->
				<div>Login</div>
				<input type=text id="Login"></input>
				<div>Nom</div>
				<input type=text id="Nom"></input>
				<div>Mot de passe</div>
				<input type=password id="MotDePasse"></input>
				<input type=button id="valider" value="valider"></input>
			<!--</form>-->
		</div>
		<div id="form2">
			<input id="proposer" type=button value="Proposer son aide"></INPUT>
		</div>
		<div id="form3">
		<input type=button id="Valider_form" value="Proposer"></option>
		</div>
		<div id="aide"></div>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
		<script  type="text/javascript" src="fonction.js" ></script>
	</body>
</html>