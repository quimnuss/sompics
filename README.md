# sompics

A silly Game for Funk together

# Credits

[Tileset and more](https://pixelfrog-assets.itch.io/kings-and-pigs) by PixelFrog
[2 Impact Wet](https://freesound.org/s/376818/) by original_sound License: Attribution 3.0
[Miracle Arp](https://freesound.org/s/347725/) by newagesoup License: Attribution NonCommercial 4.0
[Medieval Art](https://gandalfhardcore.itch.io/free-pixel-art-male-and-female-character) by gandalfhardcore

# Joystick

To play with android joysticks find the joystick [here](https://github.com/diegoquintanav/go-joystick)

and start with

```bash
go run cmd/joystick-client/client.go  -serverAddr ws://192.168.1.xxx:9080 -clientAddr 0.0.0.0:8081 -clientName ""
```
Then go with your phone to the host ip `http://192.168.1.xxx:8081`, put a valid name in the field,
connect and jump!

(requires go installed, e.g. `sudo apt install golang-go`)

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

# Tools

Convert gif to spritesheet with

```
convert -coalesce input.gif frames/%02d.png
montage -mode concatenate -quality 100 -background transparent -tile 5x frames/*.png spritesheet.png
```
