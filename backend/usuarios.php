<?php

namespace App\usuarios;
require "../vendor/autoload.php";
use App\Controller\UserController;
use App\Controller\AutorizadoController;
$users = new UserController();
$autorizado= new AutorizadoController();
$autorizado->autorizado();

$body = json_decode(file_get_contents('php://input'), true);
$id=isset($_GET['id'])?$_GET['id']:'';
switch($_SERVER["REQUEST_METHOD"]){
    case "POST";
        $resultado = $users->insert($body);
        echo json_encode(['status'=>$resultado]);
    break;
    case "GET";
        if(!isset($_GET['id'])){
            $resultado = $users->select();

            echo json_encode(["status"=>true,"usuarios"=>$resultado]);
        }else{
            $resultado = $users->selectId($id);
            $enderecos = $users->selectEndId($_GET['id']);
            echo json_encode(["status"=>true,"usuario"=>$resultado[0],"enderecos" =>$enderecos]);
        }
       
    break;
    case "PUT";
        $resultado = $users->update($body,intval($_GET['id']));
        echo json_encode(['status'=>$resultado]);
    break;
    case "DELETE";
        $resultado = $users->delete(intval($_GET['id']));
        echo json_encode(['status'=>$resultado]);
    break;  
}