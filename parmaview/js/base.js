import { setMainDisplay } from "./menu_main.js";   
import { sourceVariables } from "./functions.js";

// This file will set the base display of the Paramanode4 web interface
// It is a 5 part layout.
// The first thre parts are always seen - with a header, middle and footer. 
// The other two layers are not alwayhs seen - a fixed posision version element, 
// and a black veil for transitions.

// Creates the version element - it will only be seen in the Main Menu
const mainVersion = document.createElement("div");
mainVersion.id = "version";
mainVersion.innerText = "Version: 4.0.0";
mainVersion.style.cssText ="font-size: min(1.3vw, 15.6px); position: absolute; top: min(2vw, 24px); left: min(2vw, 24px); color: rgb(224, 31, 163);"
document.body.insertBefore(mainVersion, document.body.firstChild);

// Create the heading div, to be reused for various pages
let mainHeading = document.createElement("h1");
mainHeading.id = "heading";
mainHeading.className = "header";
mainHeading.innerText = "";
mainVersion.after(mainHeading);

// This is the spacer div, used to position the upper horizontal bar, making an equidistant gap
// above and below the heading
let mainSpacer = document.createElement("div");
mainSpacer.id = "spacer";
mainSpacer.className = "spacer";
mainHeading.after(mainSpacer);

// This the middle div which will contain parmaboxes
let mainMiddle = document.createElement("div");
mainMiddle.id = "middle";
mainMiddle.className = "middle";
mainSpacer.after(mainMiddle);

// This is the footer div which has 3 set parmaboxes, but in other pages will be buttons as well
let mainFooter = document.createElement("div");
mainFooter.id = "footer";
mainFooter.className = "footer";
mainMiddle.after(mainFooter);

// This is a black veil used for transitions
let fadeElement = document.createElement('div');
fadeElement.id = `fade`
fadeElement.style.cssText = `position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: black;
        opacity: 0;
        pointer-events: none;
        transition: opacity 0.5s;
        z-index: 9999;`;
document.body.appendChild(fadeElement);

// Source Parmanode4 variables from json files
// This exports a promise waiting on json data, and should be imported by other files
// Usage is someVariable = variablesPromise.then(data => data)
// or variablesPromise.then(data => { someVariable = data; });
export let variablesPromise = sourceVariables();

// Run main display
setMainDisplay();