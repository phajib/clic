function success() {
    if(document.getElementById("shoot_title").value===""){
            document.getElementById('create_entry').disabled = true;
        } else {
            document.getElementById('create_entry').disabled = false;
        }
    }