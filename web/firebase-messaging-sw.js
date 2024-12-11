importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDiuBou-3RduJOBCFOZDqEuWYt0yJvgUXU",
  authDomain: "my-food-c1459.firebaseapp.com",
  projectId: "my-food-c1459",
  storageBucket: "my-food-c1459.appspot.com",
  messagingSenderId: "609386859120",
  appId: "1:609386859120:web:47b61844e19b9ee1f402b5",
  measurementId: "G-Q2BZYSDVMD"
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});