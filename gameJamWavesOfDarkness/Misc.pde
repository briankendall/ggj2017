
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

color soundForLightColor(int lightColor, int lightAlpha) {
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