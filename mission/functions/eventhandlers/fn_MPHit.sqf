/*──────────────────────────────────────────────────────┐
│   Author: Connor                                      │
│   Steam:  https://steamcommunity.com/id/_connor       │
│   Github: https://github.com/ConnorAU                 │
│                                                       │
│   Please do not modify or remove this comment block   │
└──────────────────────────────────────────────────────*/

#define THIS_FUNC GG_eventhandler_fnc_MPHit

#include "..\defines.inc"

#define VAR_AUTOHEAL_THREAD FUNC_SUBVAR_RAW(autoheal_thread)

params ["_unit", "_causedBy"];

if (_causedBy == player && {_unit != player}) then {
	[] spawn GG_ui_fnc_hitmarker;
};

if (_unit == player) then {
	terminate (GVAR(MNS,QUOTE(VAR_AUTOHEAL_THREAD),scriptNull));
	VAR_AUTOHEAL_THREAD = [] spawn GG_system_fnc_autoheal;
};