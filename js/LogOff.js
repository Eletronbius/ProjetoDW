document.getElementById('LogOff').addEventListener('click', logOff);
function logOff(){
    sessionStorage.removeItem("token","");
    window.location.href = "index.html";
}