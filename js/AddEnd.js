
function AddEnd() {
    var token = sessionStorage.getItem('token');
    const idend = document.getElementById('getUserId').value;
    const cepUsuario = document.getElementById('cep').value;
    const ruaUsuario = document.getElementById('rua').value;
    const bairroUsuario = document.getElementById('bairro').value;
    const cidadeUsuario = document.getElementById('cidade').value;
    const ufUsuario = document.getElementById('uf').value;
    const end = {
        idend: idend,
        cep:cepUsuario,
        rua:ruaUsuario,
        bairro:bairroUsuario,
        cidade:cidadeUsuario,
        uf:ufUsuario
    };

    fetch('/backend/endereco.php', { 
        method: 'POST',
        headers: {
            'Authorization':  token,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(end)
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
            alert("Endereço Registrado: " + JSON.stringify(data));
       
    })
    .catch(error => alert('Erro na requisição: ' + error));
}
