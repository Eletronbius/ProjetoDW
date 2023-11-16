document.getElementById('getAllButton').addEventListener('click', getAll);
function getAll() {
    var token = sessionStorage.getItem('token');
    fetch('/backend/produtos.php', {
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
    const users = data.usuarios;  
    const usersDiv = document.getElementById('usersList');
    usersDiv.innerHTML = ''; 

    const list = document.createElement('ul');
    users.forEach(user => {
        const listItem = document.createElement('li');
        listItem.classList.add("transition-all")
        listItem.classList.add("duration-200")
        listItem.classList.add("text-base");
        listItem.classList.add("subpixel-antialiased");
        listItem.classList.add("hover:text-sky-500");
        listItem.classList.add("hover:font-bold");
        listItem.textContent = `${user.id} - ${user.nome} - ${user.preco} - ${user.quantidade}`;
        list.appendChild(listItem);
    });

    usersDiv.appendChild(list);
}
getAll();