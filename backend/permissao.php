<?php

namespace App\permissao;
require "../vendor/autoload.php";
use App\Controller\PerfilPermissaoController;

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
    case "POST":
        $perfilid = isset($body['perfilId']) ? $body['perfilId'] : '';
        $resultado = $controller->adicionarPermissao($perfilid, $body['nome']);
        echo json_encode(['status' => $resultado]);
        break;

        case "GET":
            if ($perfilId) {
               
                $resultado = $controller->obterPermissoesDoPerfil($perfilId);
                if (!$resultado) {
                    echo json_encode(["status" => false, "mensagem" => "Nenhum resultado encontrado"]);
                    exit;
                } else {
                    echo json_encode($resultado);
                    exit;
                }
            } else {
                $resultado = $controller->listarTodos();
        
                if (!$resultado) {
                    echo json_encode(["status" => false, "mensagem" => "Nenhum perfil encontrado"]);
                    exit;
                } else {
                    echo json_encode($resultado);
                    exit;
                }
            }
            break;
        

    case "DELETE":
        $resultado = $controller->removerPermissao($perfilId, $body['nome']);
        echo json_encode(['status' => $resultado]);
        break;
}