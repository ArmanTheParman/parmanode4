export function clearBody() {
[...document.body.children].forEach(el => {
    if (el.tagName !== 'SCRIPT') el.remove();
  });
}

export function sourceVariables() {
  return fetch("/cgi-bin/source_variables.sh")
      .then(response => response.json())
      .then(data => data)
      .catch(error => {
          console.error('Error fetching source variables:', error);
          return null; 
      });
}

export function getInstalledApps() {

    return  fetch('/cgi-bin/installed_apps.sh')
      .then(response => response.json()) 
      .catch(error => { console.error('Error fetching installed apps:', error); })
}

export function getBlockHeight() {
  fetch("/cgi-bin/blockheight.sh")
    .then( res => res.text())
    .then( text => {
      if (text.toLowerCase().includes("file not found")) {
        document.getElementById("blockheight").textContent = "NA";
      } else {
        document.getElementById("blockheight").textContent = text.trim();
      }
    })
    .catch(function(err) {
      console.warn("Error");
    });
}

export function getBitcoinPrice() {
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

export function showPriceCycle(priceText) {
  el = document.getElementById("price");

  el.textContent = priceText;

  setTimeout(() => {
      el.textContent = "1 bitcoin";
  }, 5000); // Show "1 bitcoin" after 5 se
  setTimeout(() => {
      getBitcoinPrice(); // Restart cycle after 7.5 sec
  }, 7500);
}

export function getIP() {
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

export function fadeOut(callback) {
  const f = document.getElementById('fade');
  if (!f) return;

  f.style.pointerEvents = 'auto';  // block interactions
  f.style.opacity = '1';           // trigger fade-in

  f.addEventListener('transitionend', function handler() {
    f.removeEventListener('transitionend', handler);
    callback();                    // now run callback
  }, { once: true });
}
export function fadeIn() {
  const f = document.getElementById('fade');
  if (!f) return;

  f.style.opacity = '0';              // hide veil
  f.style.pointerEvents = 'none';     // allow clicks again
}
