import { getBlockHeight, getBitcoinPrice, getIP, fadeOut, fadeIn } from "./functions.js";   
import { setInstallAppsDisplay } from "./menu_install_apps.js";

export function setMainDisplay() {
   
  // This function sets the main display of the Paramanode4 web interface
    document.getElementById("version").style.display = "block";
    document.getElementById("heading").innerText = "PARMANODE4";
    document.getElementById("middle").innerHTML =  "";
    document.getElementById("footer").innerHTML =  "";
  // These are the parmaboxes that will live in the the 'middle' div, but could be used elsewhere
    let mainMiddleBoxes = [];

    for (let i = 0; i < 9; i++) {
    mainMiddleBoxes[i] = document.createElement("div");
    mainMiddleBoxes[i].className = "parmabox";
    }

    let mainMiddleBoxNames = [ "INSTALL<br>APPS", "USE<br>APPS", "REMOVE<br>APPS", 
                                "PRODUCTS", "BITCOIN", "EDUCATION",
                                "UPDATE", "OVERVIEW", "PREMIUM" ];

    let mainMiddleBoxIDs = [ "installapps", "use", "remove", "products", "bitcoin",
                               "education", "update", "overview", "premium" ];

    mainMiddleBoxes[4].style.color = "rgb(39, 236, 39)";
    mainMiddleBoxes[8].style.color = "rgb(11, 128, 255)";

    for ( let i = 0 ; i < 9 ; i++) {
    mainMiddleBoxes[i].innerHTML = mainMiddleBoxNames[i];
    mainMiddleBoxes[i].id        = mainMiddleBoxIDs[i];
    } 
// Use a fragment for faster loading of the DOM
    let frag = document.createDocumentFragment();
    for (let f of mainMiddleBoxes) frag.appendChild(f);

    document.getElementById("middle").appendChild(frag);


    document.getElementById("footer").innerHTML = `<div class="parmabox">BITCOIN BLOCK =&nbsp
    <span id="blockheight" style="color: rgb(57, 213, 57);">
      &nbspNA 
    </span></div>

    <div class="parmabox">1 bitcoin =&nbsp
        <span id="price" style="color: rgb(57, 213, 57);">
        1 bitcoin
        </span>
    </div>

    <div class="parmabox">IP =&nbsp
        <span id="IP" style="color: rgb(57, 213, 57);">
          80085
        </span>
    </div>`;

  getBlockHeight();
  getBitcoinPrice();
  getIP();

// make clicks work
   document.getElementById("installapps").addEventListener("mousedown", event => { 
      if (event.button === 0) fadeOut(setInstallAppsDisplay); });

  fadeIn();
}