shader_type canvas_item;

uniform float bri = 1.0;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	COLOR = vec4(col.r * bri, col.g * bri, col.b * bri, col.a);
}
