
int randomInt(int a, int b) {
    return int(random(a, b+1));
}

color colorForLightColor(int lightColor, int lightAlpha) {
    if (lightColor == LIGHT_NONE) {
        return color(0, 0, 0, 0);
    } else if (lightColor == LIGHT_RED) {
        return color(255, 0, 0, lightAlpha);
    } else if (lightColor == LIGHT_GREEN) {
        return color(0, 255, 0, lightAlpha);
    } else if (lightColor == LIGHT_BLUE) {
        return color(0, 0, 255, lightAlpha);
    } else if (lightColor == LIGHT_YELLOW) {
        return color(255, 255, 0, lightAlpha);
    } else if (lightColor == LIGHT_CYAN) {
        return color(0, 255, 255, lightAlpha);
    } else if (lightColor == LIGHT_MAGENTA) {
        return color(255, 0, 255, lightAlpha);
    } else if (lightColor == LIGHT_WHITE) {
        return color(255, 255, 255, lightAlpha);
    } else {
        return color(0,0,0,0);
    }
}

color colorForSoundColor(int soundColor, int lightAlpha) {
    if (soundColor == LIGHT_NONE) {
        return color(0, 0, 0, 0);
    } else if (soundColor == SOUND_RED) {
        return color(255, 0, 0, lightAlpha);
    } else if (soundColor == SOUND_GREEN) {
        return color(0, 255, 0, lightAlpha);
    } else if (soundColor == SOUND_BLUE) {
        return color(0, 0, 255, lightAlpha);
    } else if (soundColor == SOUND_YELLOW) {
        return color(255, 255, 0, lightAlpha);
    } else if (soundColor == SOUND_CYAN) {
        return color(0, 255, 255, lightAlpha);
    } else if (soundColor == SOUND_ORANGE) {
        return color(255, 127, 0, lightAlpha);
    } else if (soundColor == SOUND_PURPLE) {
        return color(127, 0, 255, lightAlpha);
    } else {
        return color(0,0,0,0);
    }
}
