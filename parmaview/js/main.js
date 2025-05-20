export function setMainDisplay() {
    const mainVersion = document.createElement("div");
    mainVersion.id = "version";
    mainVersion.innerText = "Version: 4.0.0";
    mainVersion.style.cssText ="font-size: 1.3rem; position: fixed; top: 5vw; left: 5vw; color: rgb(167,115,54);" 
    document.body.insertBefore(mainVersion, document.body.firstChild);
   
    let mainHeading = document.createElement("h1");
    mainHeading.id = "heading";
    mainHeading.className = "header";
    mainHeading.innerText = "PARMAMNODE4";
    mainVersion.after(mainHeading);

    let mainSpacer = document.createElement("div");
    mainSpacer.id = "spacer";
    mainSpacer.className = "spacer";
    mainHeading.after(mainSpacer);



    let mainMiddle = document.createElement("div");
    mainMiddle.id = "middle";
    mainMiddle.className = "middle";
    mainSpacer.after(mainMiddle);

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

    for ( let i = 0 ; i < 9 ; i++) {
    mainMiddleBoxes[i].innerHTML = mainMiddleBoxNames[i];
    mainMiddleBoxes[i].id        = mainMiddleBoxIDs[i];
    }

    let frag = document.createDocumentFragment();
    for (let f of mainMiddleBoxes) frag.appendChild(f);

    mainMiddle.appendChild(frag);


    let mainFooter = document.createElement("div");
    mainFooter.id = "footer";
    mainFoooter.className = "footer";
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
</div>`
   mainMiddle.after(mainFooter);
}