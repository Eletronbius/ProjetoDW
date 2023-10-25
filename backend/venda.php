<?php

namespace App\venda;
require "../vendor/autoload.php";

use App\Controller\VendaController;

$vendas = new VendaController();

$body = json_decode(file_get_contents('php://input'), true);
$id=isset($_GET['id'])?$_GET['id']:'';
switch($_SERVER["REQUEST_METHOD"]){
    case "POST":
        $resultado = $vendas->insert($body);
        echo json_encode(['status'=>$resultado]);
        break;
    case "GET":
        $resultado = $vendas->selectprodId($body);
        echo json_encode(['status'=>$resultado]);
        break;
    default:
        echo json_encode(['status' => false, 'message' => 'Método não permitido']);
        break;
    
}