#version 150

#moj_import <config.glsl>
#moj_import <vsh_util.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform mat4 ProjMat;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * vertexColor;
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

    fragColor = color * ColorModulator;
}
