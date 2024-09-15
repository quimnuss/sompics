# TODO

## now

- [ ] configurable number of players in-game

We can just add the name in the persistence array if it matches possible names
and either restart level or spawn_one in PlayerSpawner reacting to a new_player signal
Available on the first 2 levels only for simplicity (no attached, no flying)

- [ ] DrBack defeat on level 17 (animation and fireworks on defeat)
- [ ] Friday Timer
- [ ] Prevent double estalvi on level restart
- [ ] Fites Persistence (don't recatch fita during a playthru)

## next

- [ ] Acció POs
- [ ] Place latest collectibles
- [ ] GooseLuis Money
- [ ] Collectibles cards forward backward arrows
- [ ] estalvi persistence (in case of restart)
- [ ] Credits

## later

- [ ] Intro level: after the bridge
- [ ] Resum del torn de telèfon tipo tomàtic
- [ ] death animation
- [ ] noves cares
- [ ] level transition
- [ ] better game over transition
- [ ] juice

# Done

- [x] Fites Screen
- [x] Free CE
- [x] Dialogic Astroboy
- [x] GooseLuis level 8.5 (spawn from crate, explain, and then fites)
- [x] Intermissions
- [x] Place Collectibles
- [x] Collectibles actor
- [x] reorder levels, customizable order
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

# fites map

{
'level_0.tscn' : [],
'level_1.tscn' : [ 'fita_erp_todo1.tres'],
'level_1_5.tscn' : [ 'fita_dades_balanc_de_costos.tres'],
'level_2.tscn' : [ 'fita_dades_pmkanbanize.tres'],
'level_3.tscn' : [ 'fita_webapps_representa.tres'],
'level_3_5.tscn' : [ 'fita_po_odoo.tres'],
'level_4.tscn' : [ 'fita_dades_transoceanics.tres'],
'level_4_5.tscn': [],
'level_5.tscn' : [ 'fita_suport_nsx.tres', 'fita_suport_sm.tres'],
'level_6.tscn' : [ 'fita_webapps_indexada.tres'],
'level_6_5.tscn' : [ 'fita_webapps_components.tres'],
'level_7.tscn' : [ 'fita_technocuca_authentik.tres', 'fita_suport_authentik.tres'],
'level_8.tscn' : [ 'fita_webapps_trucades.tres'],
'level_8_5.tscn' : [ 'fita_webapps_solidar.tres', 'fita_technocuca_solidar.tres'],
'level_9.tscn' : [ 'fita_erp_todo4.tres'],
'level_9_5.tscn' : [],
'level_10.tscn' : [ 'fita_erp_todo3.tres'],
'level_11.tscn' : [ 'fita_erp_todo2.tres'],
'level_12.tscn' : [ 'fita_erp_todo1.tres'],
'level_12_5.tscn' : [ 'fita_po_openproject.tres', 'fita_technocuca_openproject.tres'],
'level_13.tscn' : [ 'fita_dades_ingesta_cicd.tres'],
'level_13_5.tscn' : [],
'level_14.tscn' : [ 'fita_erp_todo5.tres'],
'level_15.tscn' : [ 'fita_technocuca_novetats.tres'],
'level_15_5.tscn' : [ 'fita_dades_jardiner.tres'],
'level_16.tscn' : [ 'fita_webapps_generation.tres'],
'level_16_5.tscn' : [],
'level_17.tscn' : [],
'level_17_5.tscn' : [],
'level_18.tscn' : [],
}

fita_po_deute_tecnic.tres
fita_po_mindset.tres
fita_technocuca_radar.tres
fita_webapps_novaweb.tres
fita_webapps_react.tres
fita_webapps_webforms.tres

