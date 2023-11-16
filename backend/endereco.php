<?php
namespace App\endereco;
require '../vendor/autoload.php';  


use App\Controller\UserController;
use App\Model\Endereco;
use App\Controller\EnderecoController;
use App\Model\Model;

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: * ' );
header('Access-Control-Allow-Methods: OPTIONS, GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');
header('Cache-Control: no-cache, no-store, must-revalidate');

$usercontroller = new UserController();
$endereco = new Endereco();
$db= new Model();
$data = json_decode(file_get_contents('php://input'), true);
switch($_SERVER["REQUEST_METHOD"]){
case 'POST':
    
            $endereco->setCep($data['cep']);
            $endereco->setRua($data['rua']);
            $endereco->setBairro($data['bairro']);
            $endereco->setCidade($data['cidade']);
            $endereco->setUf($data['uf']);
            $endereco->setIduser($data['idend']);
            $enderecoController= new EnderecoController($endereco);
            $resultado = $enderecoController->insert();

                echo json_encode(['status'=>$resultado]);
break;
    case 'DELETE':
        
        $resultado = $db->delete('endereco',['id'=>intval($_GET['id'])]);
        echo json_encode(['status'=>$resultado]);
    break;
}
