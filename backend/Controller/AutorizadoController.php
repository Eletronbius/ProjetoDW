<?php
namespace App\Controller;


class AutorizadoController{

  private $ips_permitidos;
  private $origesPermitidas;

  public function __construct(){

    $this->ips_permitidos = ['::1', '10.67.254.116','10.67.254.79'];
    $this->origesPermitidas = ['localhost',     ];

  }
  public function autorizado(){
      
    header('Content-Type: application/json');
    header('Access-Control-Allow-Origin: * ' );
    header('Access-Control-Allow-Methods: OPTIONS, GET, POST, PUT, DELETE');
    header('Access-Control-Allow-Headers: Content-Type');
    header('Cache-Control: no-cache, no-store, must-revalidate');

    $this->verificaIP();
    //$this->verificaOrigem();
  }
  public function verificaIP(){
    if (!in_array($_SERVER['REMOTE_ADDR'],  $this->ips_permitidos)) {
        echo json_encode(['error' => 'Acesso não autorizado IP: '], 403);
        exit;
    }

  }
  public function verificaOrigem(){
    if(!in_array($_SERVER['HTTP_ORIGIN'], $this->origesPermitidas)){
      echo json_encode(['error' => 'Acesso não autorizado'], 403);
      exit;
  }

  }

}