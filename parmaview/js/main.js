export function setmaindisplay() {

const mainVersion = document.createElement("div");
mainVersion.id = "version";
mainVersion.innerText = "Version: 4.0.0";
mainVersion.style.cssText ="font-size: 1.3rem; position: fixed; top: 5vw; left: 5vw; color: rgb(167,115,54);" 
document.body.insertBefore(mainVersion, document.body.firstChild);

let mainHeading = document.createElement("h1");
mainHeading.id = "heading";
mainHeading.innerText = "PARMAMNODE4";
mainHeading.after(mainVersion);

let mainSpacer = document.createElement("div");
mainSpacer.id = "spacer";
mainSpacer.after(mainHeading);

let mainMiddle = document.createElement("div");
mainMiddle.id = "middle";
mainMiddle.after(mainSpacer);

}