export function clearBody() {
[...document.body.children].forEach(el => {
    if (el.tagName !== 'SCRIPT') el.remove();
  });
}