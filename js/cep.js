function limpa_formulário_cep() {
  //Limpa valores do formulário de cep.
  document.getElementById('rua').value=("");
  document.getElementById('bairro').value=("");
  document.getElementById('cidade').value=("");
  document.getElementById('uf').value=("");
  document.getElementById('ibge').value=("");
}

function meu_callback(conteudo) {
if (!("erro" in conteudo)) {
  //Atualiza os campos com os valores.
  document.getElementById('rua').value=(conteudo.logradouro);
  document.getElementById('bairro').value=(conteudo.bairro);
  document.getElementById('cidade').value=(conteudo.localidade);
  document.getElementById('uf').value=(conteudo.uf);
  document.getElementById('ibge').value=(conteudo.ibge);
  let rua = document.getElementById('rua').value;
  let cidade = document.getElementById('cidade').value;
  let endereco = rua+","+cidade;
  var requestOptionsMap = {
    method: 'GET'
  };
  fetch("https://nominatim.openstreetmap.org/search?q="+endereco+"&format=json&limit=1", requestOptionsMap)
        .then(response => response.json())
        .then(data => Mapa(data[0].lat,data[0].lon))
        .catch(error => console.log('error', error));
} //end if.
else {
  //CEP não Encontrado.
  limpa_formulário_cep();
  alert("CEP não encontrado.");
}
}

function pesquisacep(valor) {
if(!document.getElementById("mapa")){
  const mapaContainer = document.getElementById("mapaContainer");
  const mapa = document.createElement('div');
  mapa.setAttribute("id", "mapa")
  mapa.classList.add("w-48");
  mapa.classList.add("h-48");
  mapa.classList.add("rounded-lg");
  mapa.classList.add("my-4");
  mapa.classList.add("shadow-lg");
  mapaContainer.appendChild(mapa);
}


//Nova variável "cep" somente com dígitos.
var cep = valor.replace(/\D/g, '');

//Verifica se campo cep possui valor informado.
if (cep != "") {

  //Expressão regular para validar o CEP.
  var validacep = /^[0-9]{8}$/;

  //Valida o formato do CEP.
  if(validacep.test(cep)) {

      //Preenche os campos com "..." enquanto consulta webservice.
      document.getElementById('rua').value="...";
      document.getElementById('bairro').value="...";
      document.getElementById('cidade').value="...";
      document.getElementById('uf').value="...";
      document.getElementById('ibge').value="...";

      var requestOptions = {
        method: 'GET',
        redirect: 'follow'
      };
      
      fetch("https://viacep.com.br/ws/"+cep+"/json/", requestOptions)
        .then(response => response.json())
        .then(data => meu_callback(data))
        .catch(error => console.log('error', error));

  } //end if.
  else {
      //cep é inválido.
      limpa_formulário_cep();
      alert("Formato de CEP inválido.");
  }
} //end if.
else {
  //cep sem valor, limpa formulário.
  limpa_formulário_cep();
}
};
function Mapa(lat, lon){
  MapaOptions ={

    center:[lat,lon],
    zoom:18

  }

  let mapa= L.map('mapa', MapaOptions);
  let layer= new L.TileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png');
  mapa.addLayer(layer);
  let Marcador = new L.Marker([lat,lon]);
  Marcador.addTo(mapa);
  const Endbtn = document.getElementById("AddEnd");
  Endbtn.disabled=false;
};