<?php

namespace App\Controller;

use App\Model\Model;

class VendaController
{
    private $model;

    public function __construct()
    {
        $this->model = new Model();
    }

    public function insert($data)
    {
        // Certifique-se de validar e limpar os dados recebidos antes de inseri-los no banco de dados
        $idusuario = $data['idusuario'];
        $idproduto = $data['idproduto'];

            if($this->model->insert('vendas', ['id_usuario' => $idusuario, 'id_produto' => $idproduto])){
                return true;
            }else{
                return false;
            }
           
    }
    public function selectprodId(){
        $user = $this->model->select('produtos_por_usuario');
        return  $user;
    }
    
}