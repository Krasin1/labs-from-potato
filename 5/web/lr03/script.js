function email(elem) {
    let mail = new String(elem.value);
    if (mail.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
        document.getElementById("result").innerHTML = "Адрес правильный";
        return;
    }
    document.getElementById("result").innerHTML = "Адрес неверный";
}
let flag = 0;
function show_information() { alert("Дунаев В.Е. Группа ИКПИ-11 Практическая №4"); }

function color() {
    if(flag == 0) {
        document.body.style.backgroundColor = "#fff700";
        flag = 1;
    } else{
        document.body.style.backgroundColor = 'white';
        flag = 0;
    }
}
