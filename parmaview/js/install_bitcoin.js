import { fadeOut, fadeIn } from "./functions.js";
import { setMainDisplay } from "./menu_main.js";   
import { getBlockHeight, getBitcoinPrice, getIP, fadeOut, fadeIn } from "./functions.js";   
import { setInstallAppsDisplay } from "./menu_install_apps.js";

export function install_Bitcoin() {
    
    //clear first
    document.getElementById("version").style.display = "none";
    document.getElementById("heading").innerHTML= "INSTALL BITCOIN";
    document.getElementById("middle").innerHTML = "";
    document.getElementById("footer").innerHTML = "";


// makes two buttons and leaves the middle as the price
document.getElementById("footer").innerHTML = `
        <i id="backbutton" class="material-icons parmabox button" style="font-size: 4.5vw">arrow_back</i>
        <i id="middlebutton" class="parmabox">1 bitcoin =&nbsp
            <span id="price" style="color: rgb(57, 213, 57);">
            1 bitcoin
            </span>
           </i>
        <i id="homebutton" class="material-icons parmabox button" style="font-size: 4.5vw;">home</i>`;

}