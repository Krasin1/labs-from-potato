var emailBox = document.getElementByName("mailCheck");
//
emailBox.addEventListener("submit", function(event){
    alert("lol");
    if(event.key == "Enter") {
        alert("lol");
        document.getElementById("b").click();
    }
})

function email(elem) {
    let mail = new String(elem.value);
    if (mail.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
        document.getElementById("result").innerHTML = "Адрес правильный";
        return;
    }
    document.getElementById("result").innerHTML = "Адрес неверный";
}

