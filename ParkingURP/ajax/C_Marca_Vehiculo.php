<?php

require_once "../modelos/M_Marca_Vehiculo.php";

$m_marca_vehiculo = new M_Marca_Vehiculo();

switch ($_GET["op"]) {
	case 'selectMarcaVehiculo':

			$rspta = $m_marca_vehiculo->select();

			while ($reg = $rspta->fetch_object()) {
				echo '<option value="' . $reg->id_marca_vehiculo . '">' . $reg->nombre . '</option>';
			}
			break;
}

?>