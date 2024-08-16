# sompics

A silly Game for Funk together

# Credits

[Tileset and more](https://pixelfrog-assets.itch.io/kings-and-pigs) by PixelFrog
[2 Impact Wet](https://freesound.org/s/376818/) by original_sound License: Attribution 3.0

# Websockets

To test the websockets open a browser devtools, go to console and run

``javascript
const ws = new WebSocket('ws://localhost:9080')
ws.onmessage = function (e) { console.log(e.data) };
ws.send('marta-move_left-0');
```
when done `ws.close()`.

You can open several sockets to simulate several clients.

# TODO

## base de la casa

- [ ] parametrize levels to number of players
     - [ ] 3,4,5,6,8,9,11,12,13,14
- [ ] Dialogic Astroboy
- [ ] fix rope
- [ ] Make platform N pics

## columnes

- [ ] fancy jump
- [ ] per 29 jugadors

## nata del pastís

- [ ] death animation
- [ ] noves cares
- [ ] level transition
- [ ] better game over transition
- [ ] juice

# Done

- [x] N websockets at the Persistence script
- [x] dev team
- [x] fancy levels
- [x] copy easy levels from game
- [x] first milestone 5 nivells
- [x] second milestone 10 nivells
- [x] weight platform
- [x] buttons
- [x] rope
