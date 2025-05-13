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
            const price = "$" + data.bitcoin.usd.toLocaleString();
            showPriceCycle(price);
        })
        .catch(err => {
            console.warn("NA");
            showPriceCycle("1 bitcoin");
        });
}

function showPriceCycle(priceText) {
    const el = document.getElementById("price");

    el.textContent = priceText;

    setTimeout(() => {
        el.textContent = "1 bitcoin";
    }, 5000); // Show "1 bitcoin" after 5 sec

    setTimeout(() => {
        getBitcoinPrice(); // Restart cycle after 7.5 sec
    }, 7500);
}
// Start the loop
getBitcoinPrice();

let installedApps;
function getInstalledApps() {
    return fetch("/cgi-bin/get_installed_apps.sh")
       .then(function(response) { return response.json(); })
       .then(function(json) { installedApps = json; return installedApps; });
}
