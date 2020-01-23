'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/assets/assets/fonts/weibei-sundial.ttf": "288192217261833d3f531df5b0384e03",
"/assets/assets/fonts/xiaozhuan-sundial.ttf": "583dff5d19b45014aa62c400e18dfd71",
"/assets/assets/fonts/weathericons-regular-webfont.ttf": "4618f0de2a818e7ad3fe880e0b74d04a",
"/assets/assets/images/2.0x/gnomon-bottom.png": "1a97bb9c0bb671d4cda4e0209b6dacdd",
"/assets/assets/images/4.0x/gnomon-bottom.png": "d41132eadfa846de837c6bf70c6b7286",
"/assets/assets/images/1.5x/gnomon-bottom.png": "0c3dd53d735189531e22c9f9d96014f2",
"/assets/assets/images/gnomon-bottom.png": "5613901b37f651e8fe0912d0c537f607",
"/assets/assets/images/gnomon-bottom.svg": "dba442c048b8e2ece7ea14ce5413f953",
"/assets/assets/images/3.0x/gnomon-bottom.png": "f4f53cdc9a21ef7cd66fb3d9fb16006c",
"/assets/AssetManifest.json": "1cbea2b90b3974594a7e6334fb7a227c",
"/assets/LICENSE": "068e077992d5bbac08f2e3840ea48189",
"/assets/FontManifest.json": "535855928d546e7ef878a3d38c024ad3",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/index-prod.html": "20a1a116a3065a0c334b083fb988645f",
"/index.html": "634744d97d538e4a89cc4d2073b846ce",
"/main.dart.js": "22ddb8c5cbce428f4f4ac915a39cbe0a"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request, {
          credentials: 'include'
        });
      })
  );
});
