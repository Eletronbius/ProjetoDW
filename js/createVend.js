document.getElementById('submitButton').addEventListener('click', createVenda);
var token = sessionStorage.getItem('token');
function createVenda() {
    const idusuario = document.getElementById('idusuario').value;
    const idproduto = document.getElementById('idproduto').value;

    if (!idusuario) {
        alert("Por favor, insira um id de usuário!");
        return;
    }

    const venda = {
        idusuario: idusuario,
        idproduto: idproduto,
    };

    fetch('/backend/venda.php', { 
        method: 'POST',
        headers: {
            'Authorization':  token,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(venda)
    })
    .then(response => {
        if (!response.ok) {
            if (response.status === 401) {
                throw new Error('Não autorizado');
            } else {
                throw new Error('Sem rede ou não conseguiu localizar o recurso');
            }
        }
        return response.json();
    })
    .then(data => {
        if(!data.status){
            alert('Produto já registrado');
        }else{
            alert("Registro criado: " + JSON.stringify(data));
        } 
       
    })
    .catch(error => alert('Erro na requisição: ' + error));
}
