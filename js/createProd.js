document.getElementById('submitButton').addEventListener('click', createUser);
var token = sessionStorage.getItem('token');
function createUser() {
    const nomeProd = document.getElementById('nomeprod').value;
    const precoProd = document.getElementById('precoprod').value;
    const quantidadeProd = document.getElementById('quantidadeprod').value;

    if (!nomeProd) {
        alert("Por favor, insira um nome!");
        return;
    }

    const usuario = {
        nome: nomeProd,
        preco: precoProd,
        quantidade: quantidadeProd
    };

    fetch('/backend/produtos.php', { 
        method: 'POST',
        headers: {
            'Authorization':  token,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(usuario)
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
            alert('Produto já existe');
        }else{
            alert("Produto criado: " + JSON.stringify(data));
        } 
       
    })
    .catch(error => alert('Erro na requisição: ' + error));
}
