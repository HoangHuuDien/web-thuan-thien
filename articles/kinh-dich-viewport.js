window.ladi_viewport = function (prop) {
  var doc = document;
  prop = prop ? prop : 'innerWidth';
  var width = window[prop];
  var isMobile = width < 768;

  window.ladi_is_desktop = !isMobile;

  var desktopWidth = 960;
  var mobileWidth = 420;
  var content = '';

  if (!isMobile) {
    content = 'width=device-width, initial-scale=1.0, maximum-scale=5.0';
  } else {
    var scale = 1;
    if (mobileWidth !== width) {
      scale = width / mobileWidth;
    }
    content =
      'width=' +
      mobileWidth +
      ',user-scalable=no,initial-scale=' +
      scale +
      ',minimum-scale=' +
      scale +
      ',maximum-scale=' +
      scale;
  }

  var meta =
    doc.getElementById('viewport') ||
    doc.querySelector('meta[name="viewport"]');
  if (!meta) {
    meta = doc.createElement('meta');
    meta.id = 'viewport';
    meta.name = 'viewport';
    doc.head.appendChild(meta);
  }
  meta.setAttribute('content', content);

  doc.documentElement.classList.toggle('ladi-desktop-mode', !isMobile);
  doc.documentElement.classList.toggle('ladi-mobile-mode', isMobile);
};

window.ladi_viewport();
window.addEventListener('resize', function () {
  window.ladi_viewport();
});
