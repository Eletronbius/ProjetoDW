function updateProd() {
    const prodId = document.getElementById("getProdId").value;
    const produtoName = document.getElementById("inpuNome").value;
    const produtoPreco = document.getElementById("inpuPreco").value;
    const produtoQuantidade = document.getElementById("inpuQuantidade").value;
    const usuarioAtualizado = {
        nome: produtoName,
        preco: produtoPreco,
        quantidade: produtoQuantidade
    };

    fetch('/backend/produtos.php?id=' + prodId, { 
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(usuarioAtualizado)
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
            alert("Não pode atualizar: ");
        }else{
            alert("Produto atualizado: " + JSON.stringify(data));
        } 
        
    })
    .catch(error => alert('Erro na requisição: ' + error));
}
