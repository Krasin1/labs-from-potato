var emailBox = document.getElementById("email");

emailBox.addEventListener("keypress", function(event){
    if(event.keyCode == 13) {
        alert("lol");
        email(emailBox);
    }
})

function email(elem) {
    // alert(typeof elem.value);
    let mail = new String(elem.value);
    if (mail.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
        // alert(elem.value + "\nyes");
        document.getElementById("result").innerHTML = "Адрес правильный";
        return;
    }
    document.getElementById("result").innerHTML = "Адрес неверный";
    // alert(elem.value + "\nno");
    // return elem.match("/\S+@\S+\.\S+/");
}

