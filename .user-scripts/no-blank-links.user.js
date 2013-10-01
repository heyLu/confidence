// ==UserScript==
// @match <all_urls>
// ==/UserScript==

var blankLinks = document.querySelectorAll("a[target=_blank]");

for (var i = 0; i < blankLinks.length; i++) {
	blankLinks[i].target = "";
}
