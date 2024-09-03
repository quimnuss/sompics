# sompics

A silly Game for Funk together

# Credits

[Tileset and more](https://pixelfrog-assets.itch.io/kings-and-pigs) by PixelFrog
[2 Impact Wet](https://freesound.org/s/376818/) by original_sound License: Attribution 3.0
[Medieval Art](https://gandalfhardcore.itch.io/free-pixel-art-male-and-female-character) by gandalfhardcore

# Websockets

To test the websockets open a browser devtools, go to console and run

``javascript
const ws = new WebSocket('ws://localhost:9080')
ws.onmessage = function (e) { console.log(e.data) };
ws.send('marta-move_left-0');
```
when done `ws.close()`.

You can open several sockets to simulate several clients.

If you get a CSP violation error, try creating a dummy html without the CSP restrictions

```html
<meta http-equiv="Content-Security-Policy"
      content="default-src 'self' data: gap: ws: ssl.gstatic.com 'unsafe-inline';">
```
and open the DevTools console in that webpage.
