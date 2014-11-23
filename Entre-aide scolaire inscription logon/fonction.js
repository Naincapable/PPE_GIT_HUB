$(document).ready(function () {
    $("#valider").button();
    $("#L_valider").button();
	$("#proposer").button();
	$('#Valider_form').button();
	$('#form3').hide();
	$("#form2").hide();
	$('#form').hide();
	$('#login').hide();
	$('#Valider_form').hide();
	$('#connexion').button();
	$('#inscription').button();
	
});


$('#connexion').click(function() 
{
	$('#connexion').hide();
	$('#inscription').hide();
	$('#login').show();
});

$('#L_valider').click(function() 
{
	var login=$('#L_Login').attr('Value');
	var password=$('#L_MotDePasse').attr('Value');
	$.ajax 
	(
		{
			url: 'fonction.php',
			type: 'POST',
			data: 
			{
				function_name: 'con_user',
				function_params:
				{
					login_php:login,
					password_php:password,
				}
			},
			success : function(data)
			{
				if(data!=0)
				{
					$('#login').hide();
					$('#form2').show();
					$('#form3').show();
					$('body').append('<div id="save" value="'+data+'"</div>');
					$('#save').hide();
					afficher_aide();
				}
				else
				{
					alert('Erreur de connection !');
				}
			}
		}
	)
});

$('#inscription').click(function() 
{
	$('#connexion').hide();
	$('#inscription').hide();
	$('#form').show();
});
$('#valider').click(function() 
{
	var nom=$('#Nom').attr('Value');
	var login=$('#Login').attr('Value');
	var password=$('#MotDePasse').attr('Value');
	$.ajax 
	(
		{
			url: 'fonction.php',
			type: 'POST',
			data: 
			{
				function_name: 'add_user',
				function_params:
				{
					nom_php:nom,
					login_php:login,
					password_php:password,
				}
			},
			success : function(data)
			{
				if(data!=0)
				{
				$('#form').hide();
				$('body').append('<div id="save" value="'+data+'"</div>');
				$('#save').hide();
				$('#form2').show();
				$('#form3').show();
				afficher_aide();
				}
				else
				{
					alert('Erreur Identifiant déja choisi');
				}
			}
		}
)});

function afficher_aide()
{
	var id_util=$('#save').attr('Value');
	$.ajax 
		(
			{
				url: 'fonction.php',
				type: 'POST',
				data: 
				{
					function_name: 'afficher',
					function_params:
					{
						id_util:id_util,
					}
				},
				success : function(data)
				{
					$('#aide').append(data);
				}
			}
	)
};

$('#proposer').click(function() 
{
	var id_util=$('#save').attr('Value');
	$.ajax 
	(
		{
			url: 'fonction.php',
			type: 'POST',
			data: 
			{
				function_name: 'form_proposer',
				function_params:
				{
					id_util:id_util,
				}
			},
			success : function(data)
			{
				$('#form3').append(data);
				$('#Valider_form').show();
				$('#proposer').remove();
			}
		}
	)
});

$('#Valider_form').click(function() 
{
	var id_util=($('#save').attr('value'));
	var mat=($('#Matiere').val());
	var niv=($('#Niveau').val());
	var spec=($('#Specialiter').val());
	
	$.ajax 
	(
		{
			url: 'fonction.php',
			type: 'POST',
			data: 
			{
				function_name: 'proposer',
				function_params:
				{
					id_util:id_util,
					mat:mat,
					niv:niv,
					spec:spec,
				}
			},
			success : function(data)
			{	
			alert('success'+data);
			}
		}
	)
});