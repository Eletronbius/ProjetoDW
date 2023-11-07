<?php

namespace App\Controller;

use App\Model\Model;
use App\Model\Usuario;
use App\Model\Endereco;
use App\Controller\EnderecoController;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Exception;

class UserController {

    private $db;
    private $usuarios;
    private $enderecos;
    private $controllerenderecos;
    public function __construct() {
        $this->db = new Model();
        $this->usuarios = new Usuario();
        $this->enderecos = new Endereco();

    }
    public function select(){
        $user = $this->db->select('users');
        
        return  $user;
    }
    public function selectId($id){
        $user = $this->db->select('users',['id'=>$id]);
        
        return  $user;
    }
    public function insert($data){
        $this->usuarios->setNome($data['nome']);
        $this->usuarios->setEmail($data['email']);
        $this->usuarios->setSenha($data['senha']);
        if($this->db->insert('users', [
            'nome'=> $this->usuarios->getNome(),
            'email'=> $this->usuarios->getEmail(),
            'senha'=> $this->usuarios->getSenha()])){
            $iduser=$this->db->getLastInsertId();
            $this->enderecos->setCep($data['cep']);
            $this->enderecos->setRua($data['rua']);
            $this->enderecos->setBairro($data['bairro']);
            $this->enderecos->setCidade($data['cidade']);
            $this->enderecos->setUf($data['uf']);
            $this->enderecos->setIduser($iduser);
            $this->controllerenderecos = new EnderecoController($this->enderecos);
            if($this->controllerenderecos->insert()){
                return true;
            }
        }
        return false;
    }
    public function update($newData,$condition){
        if($this->db->update('users', $newData, ['id'=>$condition])){
            return true;
        }
        return false;
    }
    public function delete( $conditions){
        if($this->db->delete('users', ['id'=>$conditions])){
            return true;
        }
        return false;
        
    }

    public function validarToken($token){
        
        $key = "9b426114868f4e2179612445148c4985429e5138758ffeed5eeac1d1976e7443";
        $algoritimo = 'HS256';
        try {
            $decoded = JWT::decode($token, new Key($key, $algoritimo));
            return ['status' => true, 'message' => 'Token válido!', 'data' => $decoded];
        } catch(Exception $e) {
            return ['status' => false, 'message' => 'Token inválido! Motivo: ' . $e->getMessage()];
        }
    }
}
