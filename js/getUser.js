async function deleteEnd(endid){
    var token = sessionStorage.getItem('token');
    const response = await fetch('/backend/endereco.php?id=' + endid, {
        method: 'DELETE',
        headers: {
            'Authorization':  token,
            'Content-Type': 'application/json'
        }
    });
    return await response.json();
  }




function getUser() {
    const userId = document.getElementById("getUserId").value;
    var token = sessionStorage.getItem('token');
    fetch('/backend/usuarios.php?id=' + userId, {
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
            alert('Usuário não encontrado')
            document.getElementById("inpuNome").value = ''; 
        }else{
            document.getElementById("inpuNome").value = data.usuario.nome; 
            document.getElementById("inputEmail").value = data.usuario.email;
            const endList = document.getElementById("endList");
            
            if(document.getElementById("ListaEnd")){
                const ul = document.getElementById("ListaEnd");
                endList.removeChild(ul);

            }
            const ul = document.createElement("ul");
            ul.classList.add("overflow-y-auto");
            ul.classList.add("flex");
            ul.classList.add("flex-col");
            ul.classList.add("items-start");
            ul.classList.add("w-full");
            ul.setAttribute("id","ListaEnd");
            const enderecos = data.enderecos;
            enderecos.forEach(endereco => {
                const li = document.createElement('li');
                li.classList.add("transition-all")
                li.classList.add("duration-200")
                li.classList.add("text-base");
                li.classList.add("subpixel-antialiased");
                li.classList.add("hover:text-sky-500");
                li.classList.add("my-2");
                li.textContent = `${endereco.id} - ${endereco.cep} `;
                const removeBtn = document.createElement('button');
                removeBtn.textContent = "Remover";
                removeBtn.classList.add("bg-sky-400");
                removeBtn.classList.add("rounded-sm");
                removeBtn.classList.add("text-slate-50");
                removeBtn.classList.add("p-2");
                removeBtn.addEventListener('click',function() {
                    const result = deleteEnd(endereco.id);
                        alert('Endereço removido com sucesso!');
                        li.remove(); 
                });
                li.appendChild(removeBtn);
                ul.appendChild(li);
            });
            endList.appendChild(ul);
        } 
       
    })
    .catch(error => alert('Erro na requisição: ' + error));
}