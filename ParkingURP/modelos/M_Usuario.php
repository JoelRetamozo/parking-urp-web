<?php

//Incluimos inicialmente la conexion a la base de datos
require "../config/Conexion.php";

Class M_Usuario{
	//Implementamos nuestro constructor
	public function __construct(){

	}

	public function insertar($codigo, $correo){

		$password = crearPassword();

		enviarMail($correo, $password);

		$sql = "INSERT INTO T_Usuario(codigo, password, estado) VALUES ('$codigo', '$password', '1')";

		return ejecutarConsulta($sql);
	}

	function enviarMail($correo, $password){
		$subject = "Cuenta para la aplicación móvil ParkingURP";
		$headers = 'From: parkingurp@gmail.com' . "\r\n" .
    		'Reply-To: parkingurp@gmail.com' . "\r\n" .
    		'X-Mailer: PHP/' . phpversion();
 
		$message = "Su cuenta para la aplicación móvil es:" . "\r\n" . 
			"Usuario: 201415634" . "\r\n" .
			"Password: " . $password;

		mail($correo, $subject, $message);
	}

	function crearPassword(){
		$caracteres='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		$longpalabra=10;
		for($pass='', $n=strlen($caracteres)-1; strlen($pass) < $longpalabra ; ) {
  			$x = rand(0,$n);
  			$pass.= $caracteres[$x];
		}

		return $pass;
	}

}

?>