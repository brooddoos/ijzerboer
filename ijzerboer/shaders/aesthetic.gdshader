shader_type spatial;
render_mode vertex_lighting;

uniform float scale = 0.04;

void vertex() {
	vec3 v = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	v = floor(v / scale) * scale;
	VERTEX = (inverse(MODELVIEW_MATRIX) * vec4(v, 1.0)).xyz;
}