document.getElementById('submitButton').addEventListener('click', loginUser);
function loginUser() {
    const emailUsuario = document.getElementById('EmailUser').value;
    const senhaUsuario = document.getElementById('SenhaUser').value;


    if (!nomeUsuario) {
        alert("Por favor, insira um nome!");
        return;
    }

    const usuario = {
        email: emailUsuario,
        senha: senhaUsuario
    };

    fetch('/backend/login.php', { 
        method: 'POST',
        headers: {
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
        if(data.token){
            sessionStorage.setItem('item',data.token);

            alert('Login Bem Sucedido')
        }else{
            alert("Usuário logado: " + JSON.stringify(data));
        } 
       
    })
    .catch(error => alert('Erro na requisição: ' + error));
}
