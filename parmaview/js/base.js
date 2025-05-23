import { setMainDisplay } from "./menu_main.js";   

// This will set the base display of the Paramanode4 web interface

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
mainHeading.innerText = "";
mainVersion.after(mainHeading);

// This is the spacer div and is part of the 4 part layout of the main page, to give freedom to adujst Header vs middle positioning
let mainSpacer = document.createElement("div");
mainSpacer.id = "spacer";
mainSpacer.className = "spacer";
mainHeading.after(mainSpacer);

// This the middle div which will contain parmaboxes
let mainMiddle = document.createElement("div");
mainMiddle.id = "middle";
mainMiddle.className = "middle";
mainSpacer.after(mainMiddle);

// This is the footer div which has 3 set parmaboxes, but later can include buttons
let mainFooter = document.createElement("div");
mainFooter.id = "footer";
mainFooter.className = "footer";
mainMiddle.after(mainFooter);

// This is a black veil used for transitions, begining totally transparent with opacity=0
let fadeElement = document.createElement('div');
fadeElement.id = `fade`
fadeElement.style.cssText = `position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: black;
        opacity: 0.5;
        pointer-events: none;
        transition: opacity 0.5s;
        z-index: 9999;`;
document.body.appendChild(fadeElement);

setMainDisplay();