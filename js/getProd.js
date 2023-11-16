function getProd() {
    const userId = document.getElementById("getProdId").value;
    var token = sessionStorage.getItem('token');
    fetch('/backend/produtos.php?id=' + userId, {
        method: 'GET',
        headers: {
            'Authorization':  token,
            'Content-Type': 'application/json'
        }
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
            alert('Produto não encontrado')
            document.getElementById("inpuNome").value = ''; 
        }else{
            document.getElementById("inpuNome").value = data.usuario.nome; 
            document.getElementById("inpuPreco").value = data.usuario.preco; 
            document.getElementById("inpuQuantidade").value = data.usuario.quantidade; 
        } 
       
    })
    .catch(error => alert('Erro na requisição: ' + error));
}