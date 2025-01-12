// Original shader collected from: https://www.shadertoy.com/view/WsVSzV
// Licensed under Shadertoy's default since the original creator didn't provide any license. (CC BY NC SA 3.0)
// Slight modifications were made to give a green-ish effect.
// This shader was modified by April Hall (arithefirst)
// Sourced from https://github.com/m-ahdal/ghostty-shaders/blob/main/retro-terminal.glsl

float warp = 0.0; // simulate curvature of CRT monitor
float scan = 0.20; // simulate darkness between scanlines
float transparency = 1; // 0.9 means 90% of original color (10% transparent)

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // squared distance from center
    vec2 uv = fragCoord / iResolution.xy;
    vec2 dc = abs(0.5 - uv);
    dc *= dc;
    
    // warp the fragment coordinates
    uv.x -= 0.5; uv.x *= 1.0 + (dc.y * (0.3 * warp)); uv.x += 0.5;
    uv.y -= 0.5; uv.y *= 1.0 + (dc.x * (0.4 * warp)); uv.y += 0.5;
    
    // determine if we are drawing in a scanline
    float apply = abs(sin(fragCoord.y) * 0.25 * scan);
        
    // sample the texture
    vec4 texColor = texture(iChannel0, uv);
    vec3 color = texColor.rgb;
    
    // Apply scanline effect and transparency
    vec3 finalColor = mix(color, vec3(0.0), apply);
    fragColor = vec4(finalColor * transparency, texColor.a);
}
