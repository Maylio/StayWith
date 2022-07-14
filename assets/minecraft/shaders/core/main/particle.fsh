#version 150

#moj_import <fog.glsl>
#moj_import <config.glsl>
#moj_import <vsh_util.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform mat4 ProjMat;

in float vertexDistance;
in vec2 texCoord0;
in vec4 vertexColor;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }

    if (isGUI(ProjMat) == false) {
        if (color.a - (vertexDistance - (3.0 + DISTANCE)) < color.a) {
            color.a = color.a - (vertexDistance - (3.0 + DISTANCE));
        }
        if (color.a < 0.1) {
            discard;
        }
    }

    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
