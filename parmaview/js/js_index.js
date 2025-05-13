  window.addEventListener('load', function () {
    if (!document.getElementById('fade')) {
      fade = document.createElement('div');
      fade.id = 'fade';
      fade.style = `
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: black;
        opacity: 0;
        pointer-events: none;
        transition: opacity 0.5s;
        z-index: 9999;
      `;
      document.body.appendChild(fade);
    }
  });

  function fade(callback) {
    const f = document.getElementById('fade');
    f.style.pointerEvents = 'auto';
    f.style.opacity = '1';
    setTimeout(callback, 500);
  }
  
  function fadeAndRedirect(url) {
    fade = document.getElementById('fade');
    fade.style.pointerEvents = 'auto';
    fade.style.opacity = '1';
    setTimeout(() => window.location.href = url, 300);
  }

function getVersion() {
    fetch("/cgi-bin/version.sh")
        .then(function(response) {
            return response.text();
        })
        .then(function(text) {
            document.getElementById("version").textContent = text.trim();
        })
        .catch(err => {
            console.warn("Could not connect:", err.message);
        });
}
function getBlockHeight() {
    fetch("/cgi-bin/blockheight.sh")
      .then(function(res) {
        return res.text();
      })
      .then(function(text) {
        if (text.toLowerCase().includes("file not found")) {
          document.getElementById("blockheight").textContent = "NA";
        } else {
          document.getElementById("blockheight").textContent = text.trim();
        }
      })
      .catch(function(err) {
        console.warn("NA");
      });
  }
 
function getIP() {
    fetch("/cgi-bin/getip.sh")
        .then(function(response) {
            return response.text();
        })
        .then(function(text) {
            if (text.toLowerCase().includes("file not found"))  {
            document.getElementById("IP").textContent = "NA";
            } else {
            document.getElementById("IP").textContent = text.trim();
            }
        })
        .catch(err => {
            console.warn("NA");
        });
}

function getBitcoinPrice() {
    fetch("/cgi-bin/bitcoinprice.sh")
        .then(res => res.json())
        .then(data => {
            price = "$" + data.bitcoin.usd.toLocaleString();
            showPriceCycle(price);
        })
        .catch(err => {
            console.warn("NA");
            showPriceCycle("1 bitcoin");
        });
}

function showPriceCycle(priceText) {
    el = document.getElementById("price");

    el.textContent = priceText;

    setTimeout(() => {
        el.textContent = "1 bitcoin";
    }, 5000); // Show "1 bitcoin" after 5 se
    setTimeout(() => {
        getBitcoinPrice(); // Restart cycle after 7.5 sec
    }, 7500);
}
// Start the loop
getBitcoinPrice();

/*(let installedApps;
function getInstalledApps() {
    return fetch("/cgi-bin/get_installed_apps.sh")
       .then(function(response) { return response.json(); })
       .then(function(json) { installedApps = json; return installedApps; });
}*/

function loadInstalledApps()  {
    fetch("/cgi-bin/menu_installedapps.sh")
       .then(function(response) { return response.text(); })
       .then(function(text) {
            document.body=text.trim();})
}