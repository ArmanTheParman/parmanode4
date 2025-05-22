export function setMainDisplay() {
  // This function sets the main display of the Paramanode4 web interface

  // First create the version element which has a fixed position, and only seen in the Main Menu
    const mainVersion = document.createElement("div");
    mainVersion.id = "version";
    mainVersion.innerText = "Version: 4.0.0";
    mainVersion.style.cssText ="font-size: min(1.3vw, 15.6px); position: absolute; top: min(2vw, 24px); left: min(2vw, 24px); color: rgb(224, 31, 163);"
    document.body.insertBefore(mainVersion, document.body.firstChild);
  
  // Next create the Heading div
    let mainHeading = document.createElement("h1");
    mainHeading.id = "heading";
    mainHeading.className = "header";
    mainHeading.innerText = "PARMAMNODE4";
    mainVersion.after(mainHeading);

  // This is the spacer div and is part of the 4 part layout of the main page, to give freedom to adujst Header vs middle positioning
    let mainSpacer = document.createElement("div");
    mainSpacer.id = "spacer";
    mainSpacer.className = "spacer";
    mainHeading.after(mainSpacer);

// This the middle dive which will contain parmaboxes
    let mainMiddle = document.createElement("div");
    mainMiddle.id = "middle";
    mainMiddle.className = "middle";
    mainSpacer.after(mainMiddle);

// These are the parmaboxed that will live in the the 'middle' div, but could be used elsewhere
    let mainMiddleBoxes = [];

    for (let i = 0; i < 9; i++) {
    mainMiddleBoxes[i] = document.createElement("div");
    mainMiddleBoxes[i].className = "parmabox";
    }

    const mainMiddleBoxNames = [ "INSTALL<br>APPS", "USE<br>APPS", "REMOVE<br>APPS", 
                                "PRODUCTS", "BITCOIN", "EDUCATION",
                                "UPDATE", "OVERVIEW", "PREMIUM" ];

    const mainMiddleBoxIDs = [ "install", "use", "remove", "products", "bitcoin",
                               "education", "update", "overview", "premium" ];

    mainMiddleBoxes[4].style = "color: rgb(39, 236, 39)";
    mainMiddleBoxes[8].style = "color: rgb(11, 128, 255)";

    for ( let i = 0 ; i < 9 ; i++) {
    mainMiddleBoxes[i].innerHTML = mainMiddleBoxNames[i];
    mainMiddleBoxes[i].id        = mainMiddleBoxIDs[i];
    } 

  // Use a fragment for faster loading of the DOM
    let frag = document.createDocumentFragment();
    for (let f of mainMiddleBoxes) frag.appendChild(f);

    mainMiddle.appendChild(frag);

// This is the footer div which has 3 set parmaboxes, but later can include buttons
    let mainFooter = document.createElement("div");
    mainFooter.id = "footer";
    mainFooter.className = "footer";
    mainFooter.innerHTML = `<div class="parmabox">BITCOIN BLOCK =&nbsp
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
   mainMiddle.after(mainFooter);
}