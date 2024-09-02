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

# TODO

## now

- [ ] configurable number of players in-game

We can just add the name in the persistence array if it matches possible names
and either restart level or spawn_one in PlayerSpawner reacting to a new_player signal
Available on the first 2 levels only for simplicity (no attached, no flying)

- [ ] Acció POs

## next

- [ ] Dialogic Astroboy

## later

- [ ] death animation
- [ ] noves cares
- [ ] level transition
- [ ] better game over transition
- [ ] juice

# Done

- [x] level: Posicionament de plaques per carregar energia (generation)
- [x] adapt client to phone
- [x] level: 3 erp doors
- [x] level: telèfons, jardiner, contractes
- [~] fancy jump
- [x] fix rope
- [x] Intro world
- [x] per 24 jugadors
- [x] fix level 7 platforms (revert git might be enough or swap to animatable platforms)
- [x] increase time in level 10 for N players
- [x] parametrize levels to number of players
- [x] Make platform N pics
- [x] N websockets at the Persistence script
- [x] dev team
- [x] fancy levels
- [x] copy easy levels from game
- [x] first milestone 5 nivells
- [x] second milestone 10 nivells
- [x] weight platform
- [x] buttons
- [x] rope
