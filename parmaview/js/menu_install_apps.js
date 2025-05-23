import { fadeOut, fadeIn } from "./functions.js";
import { setMainDisplay } from "./menu_main.js";   
//import { fadeAndRedirect, fadeOut } from "./functions.js";

export function setInstallAppsDisplay() {
// This function sets the display for the Install Apps page

//clear first
document.getElementById("version").style.display = "none";
document.getElementById("heading").innerHTML= "INSTALL APPS";
document.getElementById("middle").innerHTML = "";
document.getElementById("footer").innerHTML = "";


document.getElementById("middle").innerHTML = `
        <div  class="parmabox">DATABASE<br>SERVER<br>APPS</div>
         <div  class="parmabox">WALLETS</div>
         <div  class="parmabox">SYSTEM<br>APPS</div>
         <div  class="parmabox">LIGHTNING<br>APPS</div>
         <div  class="parmabox"><div style="color: rgb(39,236,39);">BITCOIN<br><span style="font-size: 0.55em;">
                                     </span></div></div>
          <div  class="parmabox">BOOKS</div>
         <div  class="parmabox">PRIVACY<br>+SECURITY<br>APPS</div>
         <div  class="parmabox">OTHER</div>
         <div  style="color: rgb(3, 183, 248);" class="parmabox">PREMIUM</div>`;

document.getElementById("footer").innerHTML = `
        <i id="leftbutton" class="material-icons parmabox button" style="font-size: 4.5vw">arrow_back</i>
        <i id="middlebutton" class="parmabox">1 bitcoin =&nbsp
            <span id="price" style="color: rgb(57, 213, 57);">
            1 bitcoin
            </span>
           </i>
        <i id="rightbutton" class="material-icons parmabox button" style="font-size: 4.5vw;">home</i>`;

document.getElementById("leftbutton").addEventListener("mousedown", (event) => {
    if (event.button === 0) fadeOut(setMainDisplay); 
    });
fadeIn();
}