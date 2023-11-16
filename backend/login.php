<?php
namespace App\login;
require '../vendor/autoload.php';  


use App\Controller\UserController;

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: * ' );
header('Access-Control-Allow-Methods: OPTIONS, GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');
header('Cache-Control: no-cache, no-store, must-revalidate');

$usercontroller = new UserController();


$data = json_decode(file_get_contents('php://input'), true);
switch($_SERVER["REQUEST_METHOD"]){
case 'POST':
    $senha= $data['senha'];
    $email= $data['email'];
    $lembrar= $data['lembrar'];
    $resultado = $usercontroller->login($email,$senha,$lembrar);
    if(!$resultado['status']){
        echo json_encode($resultado);
       exit;
    }
    echo json_encode(['status' => $resultado['status'], 'message' => $resultado['message'],'token'=>$resultado['token']]);
break;
    case 'GET':
        $headers = getallheaders();
        $token = $headers['Authorization'] ?? null;
        $usuariosController = new UserController();
        $validationResponse = $usuariosController->validarToken($token);
        if ($token === null || !$validationResponse['status']) {
            echo json_encode($validationResponse['message']);
            exit;
        }
        echo json_encode($validationResponse);
        exit;
    break;
}
