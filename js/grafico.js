function getAll() {
    var token = sessionStorage.getItem('token');
    fetch('/backend/venda.php', {
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
        displayUsers(data);
    })
    .catch(error => alert('Erro na requisição: ' + error));
}
function displayUsers(data) {
    let legendas = [];
    let valores = [];
    const produtos = data.status;  
    console.log(produtos);
    produtos.forEach(user => {
        legendas.push("Usuário("+user.id+")");
        valores.push(user.quantidade_produtos);
    });
    const barColors = ["red", "green","blue","orange","blueviolet"];
                    
            new Chart("myChart", {
           // type: "bar",
            type: "pie",
            data: {
                labels: legendas,
                datasets: [{
                backgroundColor: barColors,
                data: valores
                }]
            },
            options: {
                legend: {display: false},
                title: {
                display: true,
                text: "Produtos cadastradas"
                }
            }
            });

}
getAll();

