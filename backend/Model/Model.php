<?php
namespace App\Model;
use Exception;
use PDO;
use PDOException;
 class Model {
 private $host = "localhost";
 private $db_name = "banco";
 private $username = "root";
 private $password = "Etirrisa01!";
 private $conn;
 private $db_type = "mysql"; // Opções: "mysql", "pgsql", "sqlite", "mssql"
/*Dependendo do tipo de banco de dados escolhido, você pode precisar ajustar os parâmetros de conexão ($host, $db_name, $username e $password) da seguinte forma:

          MySQL:
          
          $host: Endereço do servidor MySQL (por exemplo, 'localhost' ou o IP do servidor)
          $db_name: Nome do banco de dados MySQL
          $username: Nome de usuário para acessar o banco de dados MySQL
          $password: Senha para acessar o banco de dados MySQL
          PostgreSQL:
          
          $host: Endereço do servidor PostgreSQL (por exemplo, 'localhost' ou o IP do servidor)
          $db_name: Nome do banco de dados PostgreSQL
          $username: Nome de usuário para acessar o banco de dados PostgreSQL
          $password: Senha para acessar o banco de dados PostgreSQL
          SQLite:
          
          $host: Não é necessário para SQLite, pois é um banco de dados baseado em arquivo
          $db_name: Caminho completo para o arquivo do banco de dados SQLite (por exemplo, 'my_database.sqlite')
          $username: Não é necessário para SQLite
          $password: Não é necessário para SQLite
          SQL Server (MSSQL):
          
          $host: Endereço do servidor SQL Server (por exemplo, 'localhost' ou o IP do servidor)
          $db_name: Nome do banco de dados SQL Server
          $username: Nome de usuário para acessar o banco de dados SQL Server
          $password: Senha para acessar o banco de dados SQL Server
          */

 public function __construct() {
     $this->connect();

 }

 private function connect() {
  $this->conn = null;

  try {
    switch ($this->db_type) {
        case "mysql":
          $dsn = "mysql:host=" . $this->host . ";dbname=" . $this->db_name;
            break;
        case "pgsql":
            $dsn = "pgsql:host=" . $this->host . ";dbname=" . $this->db_name;
            break;
        case "sqlite":
            $dsn = "sqlite:" . "sqlite/test_drive.db";
            $filepath =  "sqlite/test_drive.db";
            if (!file_exists($filepath)) {
                die("Arquivo não encontrado: $filepath");
            }
            break;
        case "mssql":
           $dsn = "sqlsrv:Server=" . $this->host . ";Database=" . $this->db_name;
           break;
        default:
            throw new Exception("Database type not supported.");
      }
      if ($this->db_type == "sqlite") {
        $this->conn = new PDO($dsn);
    } else {
        $this->conn = new PDO($dsn, $this->username, $this->password);
    }
    $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $exception) {
        echo "Connection error: " . $exception->getMessage();
    } catch (Exception $exception) {
        echo $exception->getMessage();
    }
}

public function getLastInsertId() {
    return $this->conn->lastInsertId();
}
public function insert($table, $data) {
        $columns = implode(", ", array_keys($data));
        $placeholders = implode(", ", array_map(function($item) {
            return ":$item"; 
        }, array_keys($data)));
        $query = "INSERT INTO $table ($columns) VALUES ($placeholders)";
        $stmt = $this->conn->prepare($query);
        foreach ($data as $key => $value) {
            $stmt->bindValue(":$key", $value);
        }
        return $stmt->execute();
}

public function select($table, $conditions = []) {
        $query = "SELECT * FROM $table";
        if (!empty($conditions)) {
            $conditionsStr = implode(" AND ", array_map(function($item) {
            return "$item = :$item";
            }, array_keys($conditions)));
            $query .= " WHERE $conditionsStr";
        }
        $stmt = $this->conn->prepare($query);
        foreach ($conditions as $key => $value) {
            $stmt->bindValue(":$key", $value);
        }
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

public function update($table, $data, $conditions) {
        $dataStr = implode(", ", array_map(function($item) {
            return "$item = :$item"; 
        }, array_keys($data)));
        $conditionsStr = implode(" AND ", array_map(function($item) { 
            return "$item = :condition_$item"; 
        }, array_keys($conditions)));
        $query = "UPDATE $table SET $dataStr WHERE $conditionsStr";
        $stmt = $this->conn->prepare($query);
        foreach ($data as $key => $value) {
            $stmt->bindValue(":$key", $value);
        }
        foreach ($conditions as $key => $value) {
            $stmt->bindValue(":condition_$key", $value);
        }
   return $stmt->execute();
}

public function delete($table, $conditions) {
        $conditionsStr = implode(" AND ", array_map(function($item) {
            return "$item = :$item"; 
        }, array_keys($conditions)));
        $query = "DELETE FROM $table WHERE $conditionsStr";
        $stmt = $this->conn->prepare($query);
        foreach ($conditions as $key => $value) {
        $stmt->bindValue(":$key", $value);
        }
        return $stmt->execute();
    }
    public function deleteWithCustomCondition($table, $condition) {
        $query = "DELETE FROM $table WHERE $condition";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute();
    }
    public function selectPermissoesPorPerfil($perfilId) {
        $stmt = $this->conn->prepare("CALL GetPermissoesPorPerfil(:perfilid)");
        $stmt->bindValue(":perfilid", $perfilId, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    public function listarTodosOsPerfis()
    {
    $query = "SELECT id, nome FROM perfil";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function cadPermissao($permissao)
    {
    $query = "
        INSERT INTO permissoes (nome) VALUES (:nome)
    ";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(":nome", $permissao);
    return $stmt->execute();
    }
    public function associar($perfilId, $permissaoId)
    {
    $query = "
        INSERT INTO perfil_permissoes (perfilid, permissao_id) VALUES (:perfilid, :permissao_id)
    ";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(":perfilid", $perfilId);
    $stmt->bindParam(":permissao_id", $permissaoId);
    
    return $stmt->execute();
    }
    public function listarTodasPermissoes()
    {
    $query = "SELECT id, nome FROM permissoes";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    public function desassociar($perfilId, $permissaoId)
    {
    $query = "
        DELETE FROM perfil_permissoes WHERE perfilid = :perfilid AND permissao_id = :permissao_id
    ";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(":perfilid", $perfilId);
    $stmt->bindParam(":permissao_id", $permissaoId);
    return $stmt->execute();
    }
    public function listarPermissao($permissao)
    {
    $query = "
    SELECT id FROM permissoes where nome=:permissao
    ";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(":permissao", $permissao);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    public function listarPerfisPorPermissao($permissaoId)
    {
    $query = "
        SELECT perfil.id, perfil.nome 
        FROM perfil_permissoes
        JOIN perfil ON perfil.id = perfil_permissoes.perfilid
        WHERE perfil_permissoes.permissao_id = :permissao_id
    ";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(":permissao_id", $permissaoId);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
