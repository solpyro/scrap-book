///A Javascript snippet that can be saved as a bookmark, allowing you to set the font to Comic Sans on any webpage with a single mouse click
javascript:(function(){a=["a","body","div","h1","h2","h3","h4","h5","h6","span","p","b","li","td","input","textarea","font","pre","select","button"];for(i=0;i<a.length;i++) {b=document.getElementsByTagName(a[i]);for(j=0;j<b.length;j++)b[j].style.fontFamily="'Comic Sans MS'";}})();