document.getElementById('LogOff').addEventListener('click', logOff);
function logOff(){
    //$t1= "Código feito por RA2571392312010";
    sessionStorage.removeItem("token","");
    window.location.href = "index.html";
}