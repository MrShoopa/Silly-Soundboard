'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "a7468e9c74d2fe3f1cc2918e948f4d66",
"assets/assets/audio/soundboard/air_horn.mp3": "28f8817f0e7a8634bb2164ceaaa6b2ee",
"assets/assets/audio/soundboard/aol_you_got_mail.wav": "7a19b2c32e89a9bdcb694082234e461c",
"assets/assets/audio/soundboard/Baku_Got_DAMN.mp3": "3338bebb7e4fad0b7f6b4b5efe2d4257",
"assets/assets/audio/soundboard/croissant_sound.mp3": "4a413c8f20ecb45b882daf4026f03b0f",
"assets/assets/audio/soundboard/damn_son.mp3": "a6b3b134de37ec2f55e934816916fbe9",
"assets/assets/audio/soundboard/DISTORTED_Bass_Boost.mp3": "6465a8a4fbc7f0d1208065284d92d1de",
"assets/assets/audio/soundboard/HITMARKER.mp3": "7e1dd407d35b49abeddbd2ca0577a119",
"assets/assets/audio/soundboard/lets_fucking_goooo.mp3": "1cf8488e06c50e37b3ad806beb05c29e",
"assets/assets/audio/soundboard/Nate_Dog_Hold_Up.mp3": "759627607ac26ed1e43934921573b283",
"assets/assets/audio/soundboard/Smoke_Weed_Everyday.mp3": "c0f8ddc78cfe36a948e08fd818fd6392",
"assets/assets/audio/soundboard/Unreal_Tournament_Holy_Shit.wav": "222ebe50ab253fbd2402e94dad6f916d",
"assets/assets/audio/soundboard/Unreal_Tournament_Monster_Kill.mp3": "93df556b4533103c4909c6fb988cba7f",
"assets/assets/audio/soundboard/whats_gucci_gorf.mp3": "0ce330df22c00696823d537b03c8441f",
"assets/assets/audio/soundboard/windows_critical_stop.mp3": "53d87475403c9a34131d5e7420920bcc",
"assets/assets/fonts/MyFlutterApp.ttf": "500762435d6de2b8b75c8b6c5a3d6595",
"assets/assets/icons/sounds/baku.jpg": "a98360dfd2a68845e92d3d5cd4c50d84",
"assets/assets/icons/sounds/bass.jpg": "0fbc0816b537b003d703d82a9a00498c",
"assets/assets/icons/sounds/carl_wheezer.jpg": "3f76ec909bd7feaca086867a9f4fee7e",
"assets/assets/icons/sounds/garfielf.jpg": "97627f50b8f14ce9d94aa6be23111ae5",
"assets/assets/icons/sounds/letsfuckinggo.png": "9a84b5058d85544e75be6b68b15f9196",
"assets/assets/icons/sounds/letsfuckinggo.svg": "861dee5dee6a28cd7ee07d6093165e46",
"assets/assets/icons/sounds/mlg.webp": "da5a98d69f7d8224378a170ffe5cec70",
"assets/assets/icons/sounds/nate_dog.jpg": "d6910a876fd4bc7e7183ea92f705a614",
"assets/assets/icons/sounds/snoop.webp": "359bde2c462e91252dec6743e534d5e0",
"assets/assets/icons/sounds/supreme_horn.jpg": "316a8f4d30e9afc90d591fc6630b638e",
"assets/assets/icons/sounds/unreal_tournament.webp": "1186668b86a1bf9108ffce6a87f1be4b",
"assets/assets/icons/sounds/xp.jpg": "588af854f1604538d76d3365a81c335c",
"assets/assets/icons/sounds/you_got_mail.jpg": "d2b08137a7502202ce77841394d31f16",
"assets/assets/references/soundlist.json": "e241854bf7337745ff4f431209766fd4",
"assets/FontManifest.json": "1e2b2284e66a9e54db0bfe7ac4f8d5d6",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "9990fac24c7889d748b4a1a90a4738ef",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "16daa1e75c75abade096971827289f33",
"icons/Icon-192.png": "698704cb92d9a515459cc6ee65d70342",
"icons/Icon-512.png": "05c3c10cf7bb027464fae82f6ba90f12",
"index.html": "bfb475e64a3cc452e38a90e59627fb68",
"/": "bfb475e64a3cc452e38a90e59627fb68",
"main.dart.js": "50a894dee1372115eb379f775d41cb5d",
"manifest.json": "57e2b04b2a9b1384bc2c10657378f0e2",
"version.json": "99d5daa2da2f7477513c22d4eb9287e9"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
  for (var resourceKey in Object.keys(RESOURCES)) {
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
