shader_type canvas_item;

uniform sampler2D palette;
uniform int palette_size = 16;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void vertex() {
}

void fragment() {
	vec4 screen_col = textureLod(screen_texture, SCREEN_UV, 0.0);
	vec3 input_rgb = screen_col.rgb;
	
	vec3 closest = vec3(1.0,1.0,1.0);
	float min_dist = 99999.0;
	
	for(int i = 0; i < palette_size; i++){
		vec3 pal_rgb = texelFetch(palette, ivec2(i, 0), 0).rgb;
		vec3 diff = input_rgb - pal_rgb;
		float dist = dot(diff, diff);

		if (dist < min_dist){
			min_dist = dist;
			closest = pal_rgb;
		}
	}
	
	COLOR = vec4(closest, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
