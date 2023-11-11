<?php
namespace App\login;
require '../vendor/autoload.php';  

use \Firebase\JWT\JWT;
use App\Model\Model;
use App\User\User;
use App\Controller\UserController;
use App\Model\Usuario;
use App\Router;
$algoritimo='HS256';
$model = new Model();
$user = new Usuario();

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: * ' );
header('Access-Control-Allow-Methods: OPTIONS, GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');
header('Cache-Control: no-cache, no-store, must-revalidate');

$usercontroller = new UserController();
$key= "9b426114868f4e2179612445148c4985429e5138758ffeed5eeac1d1976e7443";

$data = json_decode(file_get_contents('php://input'), true);
switch($_SERVER["REQUEST_METHOD"]){
case 'POST':
if (isset($data['email']) && isset($data['senha'])) {
    $email = $data['email'];
    $password = $data['senha'];
    
    $user->setEmail($email);
    $user->setSenha($password);

    $data = $model->select('users', ['email' => $email]);
    if (!$data) {
        http_response_code(500);
        echo json_encode(['error' => 'Erro interno do servidor.']);
        exit;
    }
    if (!empty($data) && password_verify($password, $data[0]['senha'])) {
        $user->setId($data[0]['id']);

        $payload = [
            "iss" => "localhost",
            "aud" => "localhost",
            "iat" => time(),
            "exp" => time() + (60 * 60),  
            "data" => [
                "userId" => $user->getId(),
                "username" => $user->getNome(),
            ]
        ];
        
            
        $jwt = JWT::encode($payload, $key, $algoritimo);
        echo json_encode(['token' => $jwt]);
    } else {
        http_response_code(401);
        echo json_encode(['error' => 'Nome de usuário ou senha inválidos.']);
    }
} else {
    http_response_code(400);
    echo json_encode(['error' => 'Requisição inválida.']);
}
break;
    case 'GET':
        $headers = getallheaders();
        $token = $headers['Authorization'] ?? null;
        $usuariosController = new UserController();
        $validationResponse = $usuariosController->validarToken($token);
        if ($token === null || !$validationResponse['status']) {
            echo json_encode(['status' => false, 'message' => $validationResponse['message']]);
            exit;
        }
        echo json_encode(['status' => true, 'message' => 'Token válido']);
        exit;
    break;
}
