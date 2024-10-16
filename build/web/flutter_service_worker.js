'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "46e486a17e0da4b4790a4f3a3bbb3dcc",
"version.json": "a40e5f5c7e1cd7c0d9afd9fa2ab856b5",
"index.html": "a61923cbbcf876de3a5e7b4a78e0b7e9",
"/": "a61923cbbcf876de3a5e7b4a78e0b7e9",
"main.dart.js": "966ad0df0303366ec9d6839934ca0393",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "ae8cc07ba77493aaedfce40740a276a3",
"icons/logo.png": "ae8cc07ba77493aaedfce40740a276a3",
"manifest.json": "92ff9bd52812d51cc1e288651e88d8f5",
"assets/AssetManifest.json": "50ef44979917c89ec38cc09f82adf82a",
"assets/NOTICES": "251ccba9b5f0b61d36b92ef2f7abef82",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "138315bb7234166fbf1342a90baa66b1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "a868b0743d14d19ff7c37e8394b5996f",
"assets/fonts/MaterialIcons-Regular.otf": "eb6c1188c0ef975a87ddc10d193e3493",
"assets/assets/btn_wishlist_active.png": "d3fada665cf1ac06289de4a557376f7d",
"assets/assets/icon_love.png": "a2bd21c99de6934f9ce47673afb01615",
"assets/assets/icon_star.png": "8ef595ea013538fa80175db2b3ba4410",
"assets/assets/MITRAPUMITA.jpg": "dda006a1e52a61d7388b0b7aba66ec3a",
"assets/assets/alishlah1.jpeg": "d4d7a6825091c006b751d4f8d9fc048a",
"assets/assets/FKMID.jpg": "0bfd8cfc7baccd54727108412810c834",
"assets/assets/KMJJ.jpg": "57b1609a9c499768f2b1365956944ded",
"assets/assets/btn_wishlist.png": "b3a497bcc6f00913a0491d6e40d8882e",
"assets/assets/ansan.jpg": "3dca7dda1475b83dd997518df5acca43",
"assets/assets/btn_map.png": "2004e88af1315118c6c7fbbf2fe7b768",
"assets/assets/FKMWU.jpg": "e266a73f1f940451714dd937e2c83a89",
"assets/assets/korea2.jpg": "7af838f9c5eb690c37d7404b518d7189",
"assets/assets/korea1.jpg": "245e54cb436559d89a448b5faaaf77f9",
"assets/assets/logokmi.png": "de4b36157c5b62dcbb40889589a9d0a4",
"assets/assets/busan.jpg": "eb9dbfed1fd64813a8f5a02c2ac9c05c",
"assets/assets/error.png": "5d614a44d4dc35aab838ab12a5f3122f",
"assets/assets/logo.png": "ae8cc07ba77493aaedfce40740a276a3",
"assets/assets/icon_home.png": "3bcd97ce47474cb5f4c8554d9b24e682",
"assets/assets/btn_back.png": "5621ccb1da8c6891c4989641df8376b1",
"assets/assets/icon_star_grey.png": "68d20d79dcb38d219f40c74189c8e2cf",
"assets/assets/itaewon.jpg": "d508e7296ecd2e48445cf7cc146fcf1e",
"assets/assets/icon_email.png": "ddd5f83f103fd4ad010b727c80957689",
"assets/assets/daegu.jpeg": "5f7ad947d129ca1d957cca377b984cc5",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
