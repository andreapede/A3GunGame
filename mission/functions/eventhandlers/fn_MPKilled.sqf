/* ----------------------------------------------------------------------------
Project:
	https://github.com/ConnorAU/A3GunGame

Author:
	ConnorAU - https://github.com/ConnorAU

Function:
	GG_eventhandler_fnc_MPKilled

Information:
	https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#MPKilled
---------------------------------------------------------------------------- */

#include "..\defines.inc"

params ["_unit", "_killer"];

// If player or AI
if (local _unit) then {
	if (_unit == player) then {
		GG_c_deaths = GG_c_deaths + 1;
		GG_c_deathPos = getpos _unit;
		GG_c_cameraView = cameraView;
		GG_c_fireMode = weaponState player # 2;
		player setVariable ["GG_c_deaths",GG_c_deaths,true];

		GG_c_killStreak = 0;

		if (isNull _killer || {_killer == _unit}) then {
			// revert 1 weapon
			GG_c_score = (GG_c_score - 1) max 0;
			player setVariable ["GG_c_score",GG_c_score,true];
			playSound "RevertWeapon";
		};
	};

	removeAllWeapons _unit;
	{_unit removeMagazine _x} foreach magazines _unit;

	{deleteVehicle _x} foreach nearestobjects[_unit,["WeaponHolderSimulated"],5];

	if (!isPlayer _unit) then {
		_unit spawn {
			uiSleep getNumber (missionConfigFile >> "respawnDelay");
			deleteVehicle _this;
			[] call GG_ai_fnc_create;
		};
	};
};

if (local _killer) then {
	if (_killer == player) then {
		GG_c_kills = GG_c_kills + 1;
		GG_c_killStreak = GG_c_killStreak + 1;
		player setVariable ["GG_c_kills",GG_c_kills,true];
		[true] spawn GG_ui_fnc_hitmarker;
		[true] call GG_system_fnc_applyWeapon;
	};
};
