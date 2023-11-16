<?php

namespace App\permissao;
require "../vendor/autoload.php";
use App\Controller\PerfilPermissaoController;
use App\Model\Permissao;
$permissao = new Permissao();

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: OPTIONS, GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');
header('Cache-Control: no-cache, no-store, must-revalidate');

$body = json_decode(file_get_contents('php://input'), true);

$perfilId = isset($_GET['perfilId']) ? $_GET['perfilId'] : '';
$permissaoId = isset($body['permissaoId']) ? $body['permissaoId'] : '';

$controller = new PerfilPermissaoController();
switch ($_SERVER["REQUEST_METHOD"]) {

        case "GET":
                $resultado = $controller->listarPermissoes();
                if (!$resultado) {
                    echo json_encode(["status" => false, "mensagem" => "Nenhuma permissao encontrado"]);
                    exit;
                } else {
                    echo json_encode($resultado);
                    exit;
                }     
                
            break;
}