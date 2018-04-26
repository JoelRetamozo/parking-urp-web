<?php

require_once "../modelos/M_Usuario.php";

$m_usuario = new M_Usuario();

$codigo = isset($_POST["codigo"])? limpiarCadena($_POST["codigo"]):"";
$correo = isset($_POST["correo"])? limpiarCadena($_POST["correo"]):"";

switch ($_GET["op"]) {
	case 'guardar':
		$rspta = $m_usuario->insertar($codigo, $correo);
		break;
	
}

?>