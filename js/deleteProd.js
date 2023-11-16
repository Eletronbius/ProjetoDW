function deleteProd() {
    var token = sessionStorage.getItem('token');
    const prodId = document.getElementById("getProdId").value;
    fetch('/backend/produtos.php?id=' + prodId, {
        method: 'DELETE',
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
            alert("Não pode Deletar: ");
        }else{
            alert("Produto deletado: " + JSON.stringify(data));
            document.getElementById("inpuNome").value = ''; 
        } 
        
    })
    .catch(error => alert('Erro na requisição: ' + error));
}