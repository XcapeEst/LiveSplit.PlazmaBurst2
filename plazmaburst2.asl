state("flashplayer14")
{
	int active	: "flashplayer14.exe", 0x00AC8398, 0x4, 0x328, 0x44, 0x4, 0xFC, 0x334;
	int level	: "flashplayer14.exe", 0x00AC7FD4, 0x408, 0xFC, 0x1F0;
	int frame	: "flashplayer14.exe", 0x00AC7DB8, 0x10C, 0x4C;
}

startup
{
	settings.Add("isIL", false, "Individual level mode)");
}

init
{
	refreshRate = 100;
	vars.maxLvl = 0;
}

start
{
	vars.maxLvl = 0;
	return current.frame == 17 && old.frame == 16;
}

split
{
	if (!settings["isIL"] && current.level > vars.maxLvl && current.frame == 17)
	{
		vars.maxLvl = current.level;
		return true;
	}
}

reset
{
	if (!settings["isIL"]) return current.frame == 17 && old.frame == 16 && current.level == 0;
	else return current.frame == 17 && old.frame == 16;
}

update
{
	if (current.frame != old.frame) print("frame" + current.frame);
	if (current.level != old.level) print("level" + current.level);
}

isLoading
{
    return current.active == 0;
}